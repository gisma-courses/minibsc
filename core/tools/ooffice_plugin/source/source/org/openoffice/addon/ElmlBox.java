package org.openoffice.addon;

import com.sun.star.beans.PropertyVetoException;
import com.sun.star.beans.UnknownPropertyException;
import com.sun.star.beans.XPropertySet;
import com.sun.star.container.XEnumeration;
import com.sun.star.container.XEnumerationAccess;
import com.sun.star.container.XIndexAccess;
import com.sun.star.frame.XModel;
import com.sun.star.lang.IllegalArgumentException;
import com.sun.star.lang.IndexOutOfBoundsException;
import com.sun.star.lang.WrappedTargetException;
import com.sun.star.lang.XComponent;
import com.sun.star.lang.XMultiComponentFactory;
import com.sun.star.lang.XMultiServiceFactory;
import com.sun.star.lang.XServiceInfo;
import com.sun.star.text.ControlCharacter;
import com.sun.star.text.XDependentTextField;
import com.sun.star.text.XParagraphCursor;
import com.sun.star.text.XText;
import com.sun.star.text.XTextContent;
import com.sun.star.text.XTextCursor;
import com.sun.star.text.XTextDocument;
import com.sun.star.text.XTextFrame;
import com.sun.star.text.XTextRange;
import com.sun.star.text.XTextSection;
import com.sun.star.text.XTextViewCursorSupplier;
import com.sun.star.uno.Any;
import com.sun.star.uno.Exception;
import com.sun.star.uno.UnoRuntime;

public class ElmlBox extends Elements {

	private Object attribute;

	public Object attrLabel;

	public Object attrCssClass;

	private XTextRange xRange;

	public ElmlBox() {
	}

	public void setContext(XMultiComponentFactory xMultiCF, XComponent xC,
			int mode) {
		xMCF = xMultiCF;
		xComponent = xC;
		xTextDocument = (XTextDocument) UnoRuntime.queryInterface(
				XTextDocument.class, xComponent);
		xText = xTextDocument.getText();

		mxDocFactory = (XMultiServiceFactory) UnoRuntime.queryInterface(
				XMultiServiceFactory.class, xTextDocument);

		xModel = (XModel) UnoRuntime.queryInterface(XModel.class, xComponent);
		xController = xModel.getCurrentController();

		xViewCursorSupplier = (XTextViewCursorSupplier) UnoRuntime
				.queryInterface(XTextViewCursorSupplier.class, xController);
		xViewCursor = xViewCursorSupplier.getViewCursor();

		try {
			xModelCursor = xText.createTextCursorByRange(xViewCursor.getEnd());
			xParaCursor = (XParagraphCursor) UnoRuntime.queryInterface(
					XParagraphCursor.class, xModelCursor);
		} catch (java.lang.Exception e) {
			e.printStackTrace(System.out);
		}

		setMode(mode);

		xContentFactory = new ContentFactory();
		xContentAccess = new ContentAccess();
		xContentContext = new ContentContext();

	}

	public void addContent(String title, String label, String cssClass) {
		try {
			xParaCursor.gotoStartOfParagraph(false);
			

			XTextSection currentSection = xContentAccess
					.getSection(xParaCursor);
			XTextContent currentTextContent = (XTextContent) UnoRuntime
					.queryInterface(XTextContent.class, currentSection);

			if (currentTextContent != null) {
			} else {
				XTextContent frame = xContentFactory.createTextFrame();

				xText.insertTextContent(xParaCursor, frame, false);

				XTextFrame textFrame = (XTextFrame) UnoRuntime.queryInterface(
						XTextFrame.class, frame);

				XText contText = textFrame.getText();
				XTextCursor xcur = contText.createTextCursorByRange(contText
						.getStart());

				xParaCursor = (XParagraphCursor) UnoRuntime.queryInterface(
						XParagraphCursor.class, xcur);

				XPropertySet xCursorProps = (XPropertySet) UnoRuntime
				.queryInterface(XPropertySet.class, xParaCursor);

				attrCssClass = xContentFactory.createTextField("cssClass",
						cssClass);
				contText.insertTextContent(xcur.getStart(),
						(XTextContent) attrCssClass, false);

				if (!title.equals("")) {
					xParaCursor.gotoStartOfParagraph(false);
					xParaCursor.goRight((short) 2, false);
					xParaCursor.setString(title);
					xCursorProps.setPropertyValue("CharStyleName", "BoxTitle");
					xText.insertControlCharacter(xParaCursor.getEnd(),
							ControlCharacter.LINE_BREAK, false);
				}
				xParaCursor.gotoEndOfParagraph(false);
				xCursorProps.setPropertyValue("ParaStyleName", "ElmlParagraph");
				xCursorProps.setPropertyValue("CharStyleName", "Standard");
			}

		} catch (java.lang.Exception e) {
			e.printStackTrace(System.out);
		}
	}

	public void editContent(String title, String label, String cssClass) {
		xContentAccess.setTextFieldName(attrLabel, label);
		xContentAccess.setTextFieldName(attrCssClass, cssClass);
		if (!title.equals("")) {
			XPropertySet xCursorProps = (XPropertySet) UnoRuntime
					.queryInterface(XPropertySet.class, xParaCursor);
			xParaCursor.gotoStartOfParagraph(false);
			xParaCursor.goRight((short) 2, false);
			xParaCursor.setString(title);
			try {
				xCursorProps.setPropertyValue("CharStyleName", "BoxTitle");
			} catch (UnknownPropertyException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (PropertyVetoException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IllegalArgumentException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (WrappedTargetException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			try {
				xText.insertControlCharacter(xParaCursor.getEnd(),
						ControlCharacter.LINE_BREAK, false);
			} catch (IllegalArgumentException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}

	public void deleteContent() {

		com.sun.star.view.XSelectionSupplier xSelSupplier = (com.sun.star.view.XSelectionSupplier) UnoRuntime
				.queryInterface(com.sun.star.view.XSelectionSupplier.class,
						xController);
		Object oSelection = xSelSupplier.getSelection();
		com.sun.star.lang.XServiceInfo xServInfo = (com.sun.star.lang.XServiceInfo) UnoRuntime
				.queryInterface(com.sun.star.lang.XServiceInfo.class,
						oSelection);

		if (xServInfo.supportsService("com.sun.star.text.TextRanges")) {
			XIndexAccess xRangeAccess = (XIndexAccess) UnoRuntime
					.queryInterface(XIndexAccess.class, oSelection);

			try {
				xRange = (XTextRange) UnoRuntime.queryInterface(
						XTextRange.class, xRangeAccess.getByIndex(0));
			} catch (IndexOutOfBoundsException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (WrappedTargetException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}

		XText newText = xRange.getText();
		xModelCursor = newText.createTextCursorByRange(xRange);
		xParaCursor = (XParagraphCursor) UnoRuntime.queryInterface(
				XParagraphCursor.class, xModelCursor);
		XPropertySet loXPropertySet = (XPropertySet) UnoRuntime.queryInterface(
				XPropertySet.class, xParaCursor);

		XTextFrame xTextFrame = null;
		try {
			xTextFrame = (XTextFrame) ((Any) loXPropertySet
					.getPropertyValue("TextFrame")).getObject();
		} catch (UnknownPropertyException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (WrappedTargetException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		xTextFrame.dispose();
	}

	public void setContent() {
		if (popupDialog == 1) {
			try {
				createDialog("", "", "");
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else {
			addContent("", "", "");
		}
	}

	public void getContent() throws Exception {
		String elementLabel = "";
		String elementCss = "";
		Object Portion = null;
		Object innerPortion = null;
		XEnumeration xTextEnum = null;
		XEnumeration xParaEnum = null;
		boolean attributes = false;

		com.sun.star.view.XSelectionSupplier xSelSupplier = (com.sun.star.view.XSelectionSupplier) UnoRuntime
				.queryInterface(com.sun.star.view.XSelectionSupplier.class,
						xController);
		Object oSelection = xSelSupplier.getSelection();
		com.sun.star.lang.XServiceInfo xServInfo = (com.sun.star.lang.XServiceInfo) UnoRuntime
				.queryInterface(com.sun.star.lang.XServiceInfo.class,
						oSelection);

		if (xServInfo.supportsService("com.sun.star.text.TextRanges")) {
			XIndexAccess xRangeAccess = (XIndexAccess) UnoRuntime
					.queryInterface(XIndexAccess.class, oSelection);

			xRange = (XTextRange) UnoRuntime.queryInterface(XTextRange.class,
					xRangeAccess.getByIndex(0));
		}

		XText newText = xRange.getText();

		xModelCursor = newText.createTextCursorByRange(xRange);

		xParaCursor = (XParagraphCursor) UnoRuntime.queryInterface(
				XParagraphCursor.class, xModelCursor);

		xParaCursor.gotoStart(false);
		xParaCursor.gotoEnd(true);
		XEnumerationAccess xTextAccess = (XEnumerationAccess) UnoRuntime
				.queryInterface(XEnumerationAccess.class, xParaCursor);

		xTextEnum = xTextAccess.createEnumeration();

		while (xTextEnum.hasMoreElements()) {
			Portion = xTextEnum.nextElement();

			XTextRange xParaRange = (XTextRange) UnoRuntime.queryInterface(
					XTextRange.class, Portion);

			XEnumerationAccess xParaAccess = (XEnumerationAccess) UnoRuntime
					.queryInterface(XEnumerationAccess.class, xParaRange);
			xParaEnum = xParaAccess.createEnumeration();

			while (xParaEnum.hasMoreElements()) {

				innerPortion = xParaEnum.nextElement();

				XServiceInfo xParaInfo = xContentAccess
						.getServiceInfo(innerPortion);

				if (xParaInfo.supportsService("com.sun.star.text.TextPortion")) {
					String portionType = xContentAccess
							.getPortionType(innerPortion);

					if (portionType.equals("TextField")) {
						
						attributes = true;
						attribute = xContentAccess.getTextField(innerPortion);
						XDependentTextField xField = (XDependentTextField) UnoRuntime
								.queryInterface(XDependentTextField.class,
										attribute);
						XPropertySet xMaster = xField.getTextFieldMaster();
						String name = (String) xMaster.getPropertyValue("Name");

						if (name.equals("label")) {
						
						} else if (name.equals("cssClass")) {
							attrCssClass = attribute;
							elementCss = xContentAccess
									.getTextFieldName(attrCssClass);
						}

					} else if (portionType.equals("Text")) {

					} else {

					}
				}
			}
		}
		if (!attributes) {

			attrCssClass = xContentFactory.createTextField("cssClass",
					"");
			newText.insertTextContent(newText.getStart(),
					(XTextContent) attrCssClass, false);
		}
		createDialog("", elementLabel, elementCss);
	}

	public void createDialog(String elementTitle, String elementLabel,
			String elementNavTitle) throws Exception {
		xDialogController = new DialogController(this);
		xDialogController.setWindowProperties("Box", 100, 100, 170, 120);

		/* ---- LABELS ---- */
		Object title = xDialogController.createLabel("titleLabel", "[@title]",
				10, 10, 150, 14, (short) 0, false);
		xDialogController.addElement("titleLabel", title);

		Object cssClass = xDialogController.createLabel("cssClassLabel",
				"[@cssClass]", 10, 45, 150, 14, (short) 0, false);
		xDialogController.addElement("cssClassLabel", cssClass);

		/* ---- TEXTFIELDS ---- */
		Object titleTxt = xDialogController.createTextField("title",
				elementTitle, 10, 25, 150, 14, (short) 1, false, (short) 0);
		xDialogController.addElement("title", titleTxt);

		Object cssTxt = xDialogController.createTextField("cssClass",
				elementNavTitle, 10, 60, 150, 14, (short) 2, false, (short) 0);
		xDialogController.addElement("cssClass", cssTxt);

		/* ---- BUTTONS ---- */
		Object buttonOK = xDialogController.createButton("ok", "OK", 110, 95,
				50, 14, (short) 4);
		xDialogController.addElement("ok", buttonOK);
		xDialogController.attachActionListener("ok");

		Object buttonCancel = xDialogController.createButton("cancel",
				"Abbrechen", 55, 95, 50, 14, (short) 5);
		xDialogController.addElement("cancel", buttonCancel);
		xDialogController.attachActionListener("cancel");

		xDialogController.showDialog();
	}

	public void validateInput() {
		attrTitleValue = xDialogController.getControlText("title");
		//attrLabelValue = xDialogController.getControlText("label");
		String attrCssClassValue = xDialogController.getControlText("cssClass");

		if (ModeSet == MODE_NEW) {
			addContent(attrTitleValue, attrLabelValue, attrCssClassValue);
			xDialogController.closeDialog();
		} else if (ModeSet == MODE_EDIT) {
			editContent(attrTitleValue, attrLabelValue, attrCssClassValue);
			xDialogController.closeDialog();
		}
	}

}