package org.openoffice.addon;

import java.awt.Frame;

import com.sun.star.awt.ActionEvent;
import com.sun.star.awt.Rectangle;
import com.sun.star.awt.XActionListener;
import com.sun.star.awt.XButton;
import com.sun.star.awt.XControl;
import com.sun.star.awt.XControlContainer;
import com.sun.star.awt.XControlModel;
import com.sun.star.awt.XDialog;
import com.sun.star.awt.XListBox;
import com.sun.star.awt.XTextComponent;
import com.sun.star.awt.XToolkit;
import com.sun.star.awt.XWindow;
import com.sun.star.beans.UnknownPropertyException;
import com.sun.star.beans.XPropertySet;
import com.sun.star.container.ElementExistException;
import com.sun.star.container.XNameContainer;
import com.sun.star.frame.XController;
import com.sun.star.frame.XModel;
import com.sun.star.lang.EventObject;
import com.sun.star.lang.IllegalArgumentException;
import com.sun.star.lang.WrappedTargetException;
import com.sun.star.lang.XComponent;
import com.sun.star.lang.XMultiComponentFactory;
import com.sun.star.lang.XMultiServiceFactory;
import com.sun.star.ui.dialogs.XFilePicker;
import com.sun.star.uno.Exception;
import com.sun.star.uno.UnoRuntime;
import com.sun.star.uno.XComponentContext;

public class DialogController implements XActionListener {

	private XComponentContext xComponentContext = null;

	private XMultiServiceFactory xMSF;

	private XMultiComponentFactory xMCF;

	private Object dialogModel;

	private XNameContainer xNameCont;

	private Object dialog;

	private XControlContainer xControlCont;

	private XControl xControl;

	private Elements element = null;

	private XWindow xWindow;

	private XDialog xDialog;

	private XControlModel xControlModel;

	private XComponent xComponent;

	public static final int MODE_NEW = 0;

	public static final int MODE_EDIT = 1;

	public static final int MODE_DELETE = 2;

	public static final int MODE_CANCEL = 3;

	private boolean centerWindow = true;

	private XmlConverter xmlConvert;

	public DialogController(XmlConverter xml) {
		xComponent = ElementController.getXComponent();
		xComponentContext = ElmlEditor.xComponentContext;
		xmlConvert = xml;

		xMCF = ElementController.getXMCF();

		try {
			dialogModel = xMCF
					.createInstanceWithContext(
							"com.sun.star.awt.UnoControlDialogModel",
							xComponentContext);
		} catch (Exception e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}

		xMSF = (XMultiServiceFactory) UnoRuntime.queryInterface(
				XMultiServiceFactory.class, dialogModel);

		xNameCont = (XNameContainer) UnoRuntime.queryInterface(
				XNameContainer.class, dialogModel);

		try {
			dialog = xMCF.createInstanceWithContext(
					"com.sun.star.awt.UnoControlDialog", xComponentContext);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		xControlCont = (XControlContainer) UnoRuntime.queryInterface(
				XControlContainer.class, dialog);

		xControl = (XControl) UnoRuntime.queryInterface(XControl.class, dialog);

		xControlModel = (XControlModel) UnoRuntime.queryInterface(
				XControlModel.class, dialogModel);

		xControl.setModel(xControlModel);
	}
	
	public DialogController(Elements elements) {

		xComponent = ElementController.getXComponent();
		xComponentContext = ElmlEditor.xComponentContext;
		element = elements;

		xMCF = ElementController.getXMCF();

		try {
			dialogModel = xMCF
					.createInstanceWithContext(
							"com.sun.star.awt.UnoControlDialogModel",
							xComponentContext);
		} catch (Exception e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}

		xMSF = (XMultiServiceFactory) UnoRuntime.queryInterface(
				XMultiServiceFactory.class, dialogModel);

		xNameCont = (XNameContainer) UnoRuntime.queryInterface(
				XNameContainer.class, dialogModel);

		try {
			dialog = xMCF.createInstanceWithContext(
					"com.sun.star.awt.UnoControlDialog", xComponentContext);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		xControlCont = (XControlContainer) UnoRuntime.queryInterface(
				XControlContainer.class, dialog);

		xControl = (XControl) UnoRuntime.queryInterface(XControl.class, dialog);

		xControlModel = (XControlModel) UnoRuntime.queryInterface(
				XControlModel.class, dialogModel);

		xControl.setModel(xControlModel);
	}
	
	/**
	 * Show the dialog
	 * 
	 */
	public void showDialog() {

		Object toolkit = null;
		try {
			toolkit = xMCF.createInstanceWithContext(
					"com.sun.star.awt.Toolkit", xComponentContext);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		XToolkit xToolkit = (XToolkit) UnoRuntime.queryInterface(
				XToolkit.class, toolkit);

		xWindow = (XWindow) UnoRuntime.queryInterface(XWindow.class, xControl);

		if (centerWindow) {
			XModel xModel = (XModel) UnoRuntime.queryInterface(XModel.class,
					xComponent);
			XController xController = xModel.getCurrentController();

			Rectangle FramePosSize = xController.getFrame()
					.getComponentWindow().getPosSize();
			Rectangle CurPosSize = xWindow.getPosSize();

			int WindowHeight = FramePosSize.Height;
			int WindowWidth = FramePosSize.Width;
			int DialogWidth = CurPosSize.Width;
			int DialogHeight = CurPosSize.Height;

			int iXPos = ((WindowWidth / 2) - (DialogWidth / 2));
			int iYPos = ((WindowHeight / 2) - (DialogHeight / 2));

			xWindow.setPosSize(iXPos, iYPos, DialogWidth, DialogHeight,
					com.sun.star.awt.PosSize.POSSIZE);
		}
		
		xWindow.setVisible(false);
		xControl.createPeer(xToolkit, null);

		xDialog = (XDialog) UnoRuntime.queryInterface(XDialog.class, dialog);
		xDialog.execute();

		XComponent xComponent = (XComponent) UnoRuntime.queryInterface(
				XComponent.class, dialog);
		xComponent.dispose();
	}

	/**
	 * Close the dialog
	 * 
	 */
	public void closeDialog() {
		xDialog.endExecute();
	}

	/**
	 * Set the dialogModel properties of the window
	 * 
	 * @param title
	 *            the window title
	 * @param x
	 *            x value
	 * @param y
	 *            y value
	 * @param width
	 *            width of the model
	 * @param height
	 *            height of the model
	 * 
	 */
	public void setWindowProperties(String title, int x, int y, int width,
			int height) throws Exception {
		XPropertySet xPropSet = (XPropertySet) UnoRuntime.queryInterface(
				XPropertySet.class, dialogModel);

		xPropSet.setPropertyValue("PositionX", new Integer(x));
		xPropSet.setPropertyValue("PositionY", new Integer(y));
		xPropSet.setPropertyValue("Width", new Integer(width));
		xPropSet.setPropertyValue("Height", new Integer(height));
		xPropSet.setPropertyValue("Title", title);

	}

	/**
	 * Creates a new UnoControlFixedTextModel
	 * 
	 * @param text
	 *            the visible text
	 * @param name
	 *            the name of the label
	 * @param x
	 *            x value
	 * @param y
	 *            y value
	 * @param width
	 *            width of the model
	 * @param height
	 *            height of the model
	 * @param tab
	 *            tabIndex for this field
	 * @param multiline
	 *            wether this is a multiline text or not
	 * 
	 * @return labelModel as Object
	 */
	public Object createLabel(String name, String text, int x, int y,
			int width, int height, short tab, boolean multiline)
			throws Exception {

		Object labelModel = xMSF
				.createInstance("com.sun.star.awt.UnoControlFixedTextModel");
		XPropertySet xPropSet = (XPropertySet) UnoRuntime.queryInterface(
				XPropertySet.class, labelModel);

		xPropSet.setPropertyValue("PositionX", new Integer(x));
		xPropSet.setPropertyValue("PositionY", new Integer(y));
		xPropSet.setPropertyValue("Width", new Integer(width));
		xPropSet.setPropertyValue("Height", new Integer(height));
		xPropSet.setPropertyValue("Name", name);
		xPropSet.setPropertyValue("TabIndex", new Short(tab));
		xPropSet.setPropertyValue("Label", text);

		return labelModel;
	}

	/**
	 * Creates a new UnoControlEditModel
	 * 
	 * @param text
	 *            the visible text
	 * @param name
	 *            the name of the label
	 * @param x
	 *            x value
	 * @param y
	 *            y value
	 * @param width
	 *            width of the model
	 * @param height
	 *            height of the model
	 * @param tab
	 *            tabIndex for this field
	 * @param multiline
	 *            wether this is a multiline text or not
	 * @param maxtext
	 *            sets the maximum amount of characters allowed
	 * 
	 * @return textModel as Object
	 */
	public Object createTextField(String name, String text, int x, int y,
			int width, int height, short tab, boolean multiline, short maxtext)
			throws Exception {
		Object textModel = xMSF
				.createInstance("com.sun.star.awt.UnoControlEditModel");

		XPropertySet xPropSet = (XPropertySet) UnoRuntime.queryInterface(
				XPropertySet.class, textModel);

		xPropSet.setPropertyValue("PositionX", new Integer(x));
		xPropSet.setPropertyValue("PositionY", new Integer(y));
		xPropSet.setPropertyValue("Width", new Integer(width));
		xPropSet.setPropertyValue("Height", new Integer(height));
		xPropSet.setPropertyValue("Name", name);
		xPropSet.setPropertyValue("TabIndex", new Short(tab));
		xPropSet.setPropertyValue("Text", text);
		xPropSet.setPropertyValue("MultiLine", new Boolean(multiline));
		xPropSet.setPropertyValue("MaxTextLen", new Short(maxtext));
		if (name.equals("bibID") && !text.equals("")) {
			xPropSet.setPropertyValue("Enabled", Boolean.FALSE);
		}
		return textModel;
	}
	
	/**
	 * Creates a new UnoControlFileControlModel
	 * 
	 * @param text
	 *            the visible text
	 * @param name
	 *            the name of the label
	 * @param x
	 *            x value
	 * @param y
	 *            y value
	 * @param width
	 *            width of the model
	 * @param height
	 *            height of the model
	 * @param tab
	 *            tabIndex for this field
	 * @param multiline
	 *            wether this is a multiline text or not
	 * @param maxtext
	 *            sets the maximum amount of characters allowed
	 * 
	 * @return textModel as Object
	 */
	public Object createFileControl(String name, String text, int x, int y,
			int width, int height, short tab)
			throws Exception {
		Object textModel = xMSF
				.createInstance("com.sun.star.awt.UnoControlFileControlModel");

		XPropertySet xPropSet = (XPropertySet) UnoRuntime.queryInterface(
				XPropertySet.class, textModel);

		xPropSet.setPropertyValue("PositionX", new Integer(x));
		xPropSet.setPropertyValue("PositionY", new Integer(y));
		xPropSet.setPropertyValue("Width", new Integer(width));
		xPropSet.setPropertyValue("Height", new Integer(height));
		xPropSet.setPropertyValue("Name", name);
		xPropSet.setPropertyValue("TabIndex", new Short(tab));
		xPropSet.setPropertyValue("Text", text);
		return textModel;
	}

	/**
	 * Creates a new UnoControlComboBoxModel
	 * 
	 * @param text
	 *            the visible text
	 * @param name
	 *            the name of the label
	 * @param x
	 *            x value
	 * @param y
	 *            y value
	 * @param width
	 *            width of the model
	 * @param height
	 *            height of the model
	 * @param tab
	 *            tabIndex for this field
	 * @param multiline
	 *            wether this is a multiline text or not
	 * @param maxtext
	 *            sets the maximum amount of characters allowed
	 * @param ListBoxEntries
	 *            String array for the list content
	 * 
	 * @return textModel as Object
	 */
	public Object createComboBox(String name, String text, int x, int y,
			int width, int height, short tab, boolean multiline, short maxtext,
			String[] ListBoxEntries, boolean status) throws Exception {

		Object textModel = xMSF
				.createInstance("com.sun.star.awt.UnoControlComboBoxModel");

		XPropertySet xPropSet = (XPropertySet) UnoRuntime.queryInterface(
				XPropertySet.class, textModel);

		xPropSet.setPropertyValue("PositionX", new Integer(x));
		xPropSet.setPropertyValue("PositionY", new Integer(y));
		xPropSet.setPropertyValue("Width", new Integer(width));
		xPropSet.setPropertyValue("Height", new Integer(height));
		xPropSet.setPropertyValue("Name", name);
		xPropSet.setPropertyValue("TabIndex", new Short(tab));
		xPropSet.setPropertyValue("Text", text);
		xPropSet.setPropertyValue("Dropdown", Boolean.TRUE);
		xPropSet.setPropertyValue("Autocomplete", Boolean.TRUE);
		xPropSet.setPropertyValue("LineCount", new Short((short) 5));
		xPropSet.setPropertyValue("MaxTextLen", new Short(maxtext));
		xPropSet.setPropertyValue("Enabled", new Boolean(status));
		if (ListBoxEntries != null) {
			xPropSet.setPropertyValue("StringItemList", ListBoxEntries);
		}
		return textModel;
	}
	
	/**
	 * Creates a new UnoControlListBoxModel
	 * 
	 * @param text
	 *            the visible text
	 * @param name
	 *            the name of the label
	 * @param x
	 *            x value
	 * @param y
	 *            y value
	 * @param width
	 *            width of the model
	 * @param height
	 *            height of the model
	 * @param tab
	 *            tabIndex for this field
	 * @param multiline
	 *            wether this is a multiline text or not
	 * @param maxtext
	 *            sets the maximum amount of characters allowed
	 * @param ListBoxEntries
	 *            String array for the list content
	 * 
	 * @return textModel as Object
	 */
	public Object createListBox(String name, short text, int x, int y,
			int width, int height, short tab, boolean multiline,
			short lineCount, String[] ListBoxEntries, boolean status) throws Exception {

		Object textModel = xMSF
				.createInstance("com.sun.star.awt.UnoControlListBoxModel");

		XPropertySet xPropSet = (XPropertySet) UnoRuntime.queryInterface(
				XPropertySet.class, textModel);

		xPropSet.setPropertyValue("PositionX", new Integer(x));
		xPropSet.setPropertyValue("PositionY", new Integer(y));
		xPropSet.setPropertyValue("Width", new Integer(width));
		xPropSet.setPropertyValue("Height", new Integer(height));
		xPropSet.setPropertyValue("Name", name);
		xPropSet.setPropertyValue("TabIndex", new Short(tab));
		xPropSet.setPropertyValue("Dropdown", Boolean.TRUE);
		xPropSet.setPropertyValue("LineCount", new Short(lineCount));
		xPropSet.setPropertyValue("Enabled", new Boolean(status));
		if (ListBoxEntries != null) {
			xPropSet.setPropertyValue("StringItemList", ListBoxEntries);
		}
		short[] selItems = {text};
		xPropSet.setPropertyValue("SelectedItems", selItems);

		return textModel;
	}

	/**
	 * Creates a new UnoControlRadioButtonModel
	 * 
	 * @param text
	 *            the visible text
	 * @param name
	 *            the name of the label
	 * @param x
	 *            x value
	 * @param y
	 *            y value
	 * @param width
	 *            width of the model
	 * @param height
	 *            height of the model
	 * @param tab
	 *            tabIndex for this field
	 * @param multiline
	 *            wether this is a multiline text or not
	 * 
	 * @return textModel as Object
	 */
	public Object createRadioButton(String name, String text, int x, int y,
			int width, int height, boolean multiline, short checked, short tab,
			boolean status) throws Exception {

		Object radioModel = xMSF
				.createInstance("com.sun.star.awt.UnoControlRadioButtonModel");

		XPropertySet xPropSet = (XPropertySet) UnoRuntime.queryInterface(
				XPropertySet.class, radioModel);

		xPropSet.setPropertyValue("PositionX", new Integer(x));
		xPropSet.setPropertyValue("PositionY", new Integer(y));
		xPropSet.setPropertyValue("Width", new Integer(width));
		xPropSet.setPropertyValue("Height", new Integer(height));
		xPropSet.setPropertyValue("Name", name);
		xPropSet.setPropertyValue("MultiLine", new Boolean(multiline));
		xPropSet.setPropertyValue("Label", text);
		xPropSet.setPropertyValue("State", new Short(checked));
		xPropSet.setPropertyValue("TabIndex", new Short(tab));
		xPropSet.setPropertyValue("Enabled", new Boolean(status));

		return radioModel;
	}
	
	/**
	 * Creates a new UnoControlCheckBoxModel
	 * 
	 * @param text
	 *            the visible text
	 * @param name
	 *            the name of the label
	 * @param x
	 *            x value
	 * @param y
	 *            y value
	 * @param width
	 *            width of the model
	 * @param height
	 *            height of the model
	 * @param tab
	 *            tabIndex for this field
	 * @param multiline
	 *            wether this is a multiline text or not
	 * 
	 * @return textModel as Object
	 */
	public Object createCheckBox(String name, String text, int x, int y,
			int width, int height, boolean multiline, short checked, short tab,
			boolean status) throws Exception {

		Object radioModel = xMSF
				.createInstance("com.sun.star.awt.UnoControlCheckBoxModel");

		XPropertySet xPropSet = (XPropertySet) UnoRuntime.queryInterface(
				XPropertySet.class, radioModel);

		xPropSet.setPropertyValue("PositionX", new Integer(x));
		xPropSet.setPropertyValue("PositionY", new Integer(y));
		xPropSet.setPropertyValue("Width", new Integer(width));
		xPropSet.setPropertyValue("Height", new Integer(height));
		xPropSet.setPropertyValue("Name", name);
		xPropSet.setPropertyValue("MultiLine", new Boolean(multiline));
		xPropSet.setPropertyValue("Label", text);
		xPropSet.setPropertyValue("State", new Short(checked));
		xPropSet.setPropertyValue("TabIndex", new Short(tab));
		xPropSet.setPropertyValue("Enabled", new Boolean(status));

		return radioModel;
	}

	/**
	 * Creates a new UnoControlButtonModel
	 * 
	 * @param text
	 *            the visible text
	 * @param name
	 *            the name of the label
	 * @param x
	 *            x value
	 * @param y
	 *            y value
	 * @param width
	 *            width of the model
	 * @param height
	 *            height of the model
	 * @param tab
	 *            tabIndex for this field
	 * 
	 * @return buttonModel as Object
	 */
	public Object createButton(String name, String text, int x, int y,
			int width, int height, short tab) throws Exception {
		Object buttonModel = xMSF
				.createInstance("com.sun.star.awt.UnoControlButtonModel");

		XPropertySet xPropSet = (XPropertySet) UnoRuntime.queryInterface(
				XPropertySet.class, buttonModel);

		xPropSet.setPropertyValue("PositionX", new Integer(x));
		xPropSet.setPropertyValue("PositionY", new Integer(y));
		xPropSet.setPropertyValue("Width", new Integer(width));
		xPropSet.setPropertyValue("Height", new Integer(height));
		xPropSet.setPropertyValue("Name", name);
		xPropSet.setPropertyValue("TabIndex", new Short(tab));
		xPropSet.setPropertyValue("Label", text);

		return buttonModel;
	}

	/**
	 * Adds an XActionListener to the button
	 * 
	 * @param name
	 *            Name of the control
	 */
	public void attachActionListener(String name) {
		XButton xButton = null;
		Object objectButton = xControlCont.getControl(name);
		xButton = (XButton) UnoRuntime.queryInterface(XButton.class,
				objectButton);
		xButton.setActionCommand(name);
		xButton.addActionListener(this);
	}

	/**
	 * Adds objects to the dialog window
	 * 
	 * @param name
	 *            the objects name
	 * @param Element
	 *            the object to add
	 */
	public void addElement(String name, Object Element) {
		try {
			xNameCont.insertByName(name, Element);
		} catch (IllegalArgumentException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ElementExistException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (WrappedTargetException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	/**
	 * Gets the text of a TextField component
	 * 
	 * @param name
	 *            the objects name
	 * @param Element
	 *            the object to add
	 */
	public String getControlText(String name) {
		String text = null;
		Object xControl = xControlCont.getControl(name);

		XTextComponent xComp = (XTextComponent) UnoRuntime.queryInterface(
				XTextComponent.class, xControl);
		text = xComp.getText();

		return text;
	}
	
	/**
	 * Gets the currently selected String in a ListBox
	 * 
	 * @param name
	 *            the objects name
	 */
	public String getSelectedText(String name) {
		String text = null;
		short itemPos = 0;
		Object xControl = xControlCont.getControl(name);
		XListBox xComp = (XListBox) UnoRuntime.queryInterface(
				XListBox.class, xControl);
		text = xComp.getSelectedItem();
		itemPos = xComp.getSelectedItemPos();

		return text;
	}
	
	/**
	 * Gets the currently selected position in a ListBox
	 * 
	 * @param name
	 *            the objects name
	 */
	public short getSelectedPosition(String name) {
		short itemPos;
		Object xControl = xControlCont.getControl(name);
		XListBox xComp = (XListBox) UnoRuntime.queryInterface(
				XListBox.class, xControl);
		itemPos = xComp.getSelectedItemPos();

		return itemPos;
	}

	/**
	 * Gets the state of a radiobutton component
	 * 
	 * @param name
	 *            the objects name
	 * @param Element
	 *            the object to add
	 */
	public boolean getControlState(String name) {
		boolean state = false;

		XControl xControl = xControlCont.getControl(name);
		XControlModel xModel = xControl.getModel();

		XPropertySet xPropSet = (XPropertySet) UnoRuntime.queryInterface(
				XPropertySet.class, xModel);

		try {
			if (xPropSet.getPropertyValue("State").toString().equals("1")) {
				state = true;
			} else {
				state = false;
			}
		} catch (UnknownPropertyException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (WrappedTargetException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return state;
	}

	public void actionPerformed(ActionEvent actionEvent) {
		if (actionEvent.ActionCommand.equals("ok")) {
			element.validateInput();
		} else if (actionEvent.ActionCommand.equals("cancel")) {
			if (element!=null) {
				element.setMode(MODE_CANCEL);
			}
			closeDialog();
		} else if (actionEvent.ActionCommand.equals("export")) {
			xmlConvert.export();
			closeDialog();
		} else {
			if (element!=null) {
				element.setMode(MODE_CANCEL);
			}
			closeDialog();
		}
	}

	public void disposing(EventObject eventObject) {
		// TODO Auto-generated method stub
	}

}
