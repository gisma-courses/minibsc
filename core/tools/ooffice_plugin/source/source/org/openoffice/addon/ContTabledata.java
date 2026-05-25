package org.openoffice.addon;

import com.sun.star.beans.XPropertySet;
import com.sun.star.container.XEnumeration;
import com.sun.star.container.XEnumerationAccess;
import com.sun.star.container.XIndexAccess;
import com.sun.star.frame.XModel;
import com.sun.star.lang.IllegalArgumentException;
import com.sun.star.lang.XComponent;
import com.sun.star.lang.XMultiComponentFactory;
import com.sun.star.lang.XMultiServiceFactory;
import com.sun.star.lang.XServiceInfo;
import com.sun.star.text.XDependentTextField;
import com.sun.star.text.XText;
import com.sun.star.text.XTextContent;
import com.sun.star.text.XTextDocument;
import com.sun.star.text.XTextRange;
import com.sun.star.text.XTextViewCursorSupplier;
import com.sun.star.uno.Exception;
import com.sun.star.uno.UnoRuntime;

public class ContTabledata extends Elements {

	private XTextRange xTableRange;
	private XText cellText;
	private Object attribute;
	public Object attrLabel;
	public Object attrCssClass;


	public ContTabledata() {
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

		setMode(mode);

		xContentFactory = new ContentFactory();
		xContentAccess = new ContentAccess();
		xContentContext = new ContentContext();

	}

	public void addContent(String label, String cssClass, String navTitle) {
		attrLabel = xContentFactory.createTextField(
					"label", "");
		attrCssClass = xContentFactory.createTextField(
					"cssClass", "");
			try {
				cellText.insertTextContent(xTableRange, (XTextContent) attrLabel, false);
				cellText.insertTextContent(xTableRange, (XTextContent) attrCssClass, false);
			} catch (IllegalArgumentException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
	}

	public void editContent(String label, String title, String navTitle) {
		xContentAccess.setTextFieldName(attrLabel, label);
		xContentAccess.setTextFieldName(attrCssClass, title);
	}

	public void getContent() throws Exception {

		String elementTitle = "";
		String elementLabel = "";
		String elementNavTitle = "";
		Object Element = null;
		Object Portion = null;
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

			 xTableRange = ( XTextRange ) UnoRuntime.queryInterface (
					 XTextRange.class, xRangeAccess.getByIndex(0) );
			 cellText = xTableRange.getText();
			 xTableRange = cellText.getStart();
			 
			 XTextRange test = cellText.getText();
 
			 XEnumerationAccess xTextAccess = (XEnumerationAccess) UnoRuntime
				.queryInterface(XEnumerationAccess.class, test);

			 XEnumeration xVariableEnum = xTextAccess.createEnumeration();
			 
			 while (xVariableEnum.hasMoreElements()) {
					Element = xVariableEnum.nextElement();
	
					XServiceInfo xSectionInfo = xContentAccess.getServiceInfo(Element);

					if (xSectionInfo.supportsService("com.sun.star.text.Paragraph")) {
						xParaEnum = xContentAccess.createInnerParaEnum(Element);

						while (xParaEnum.hasMoreElements()) {
							Portion = xParaEnum.nextElement();
							XServiceInfo xParaInfo = xContentAccess
									.getServiceInfo(Portion);

							if (xParaInfo
									.supportsService("com.sun.star.text.TextPortion")) {
								String portionType = xContentAccess
										.getPortionType(Portion);

								if (portionType.equals("TextField")) {
									attributes = true;
									
									attribute = xContentAccess.getTextField(Portion);
									XDependentTextField xField = (XDependentTextField) UnoRuntime.queryInterface(
											XDependentTextField.class, attribute);
									XPropertySet xMaster = xField.getTextFieldMaster();
									String name = (String) xMaster.getPropertyValue("Name");
									
									if (name.equals("label")) {
										attrLabel = attribute;
										elementTitle = xContentAccess
										.getTextFieldName(attrLabel);
									} else if (name.equals("cssClass")) {
										attrCssClass = attribute;
										elementLabel = xContentAccess
										.getTextFieldName(attrCssClass);
									}
									
								} else if (portionType.equals("Text")) {
									
								} else {

								}
							}
						}
					}
				}
			 
			 if (!attributes) {
				 addContent("", "", "");
			 }
		}
		createDialog(elementTitle, elementLabel, elementNavTitle);
	}

	public void getDepending() {

	}

	public void createDialog(String attrLabel, String attrCssClass,
			String elementNavTitle) throws Exception {
		xDialogController = new DialogController(this);
		xDialogController.setWindowProperties("Tabledata", 100, 100, 170, 140);

		/* ---- LABELS ---- */
		Object title = xDialogController.createLabel("titleLabel",
				"[@label]", 10, 10, 150, 14, (short) 0,
				false);
		xDialogController.addElement("titleLabel", title);

		Object label = xDialogController.createLabel("labelLabel",
				"[@cssClass]", 10, 45, 150, 14,
				(short) 0, false);
		xDialogController.addElement("labelLabel", label);

		/* ---- TEXTFIELDS ---- */
		Object titleTxt = xDialogController.createTextField("label",
				attrLabel, 10, 25, 150, 14, (short) 1, false, (short) 0);
		xDialogController.addElement("label", titleTxt);

		Object labelTxt = xDialogController.createTextField("cssClass",
				attrCssClass, 10, 60, 150, 14, (short) 2, false, (short) 0);
		xDialogController.addElement("cssClass", labelTxt);

		/* ---- BUTTONS ---- */
		Object buttonOK = xDialogController.createButton("ok", "OK", 110, 115,
				50, 14, (short) 4);
		xDialogController.addElement("ok", buttonOK);
		xDialogController.attachActionListener("ok");

		Object buttonCancel = xDialogController.createButton("cancel",
				"Abbrechen", 55, 115, 50, 14, (short) 5);
		xDialogController.addElement("cancel", buttonCancel);
		xDialogController.attachActionListener("cancel");

		xDialogController.showDialog();
	}

	public void validateInput() {
		attrLabelValue = xDialogController.getControlText("label");
		attrTitleValue = xDialogController.getControlText("cssClass");

			if (ModeSet == MODE_NEW) {
				addContent(attrLabelValue, attrTitleValue, attrNavTitleValue);
				xDialogController.closeDialog();
			} else if (ModeSet == MODE_EDIT) {
				editContent(attrLabelValue, attrTitleValue, attrNavTitleValue);
				xDialogController.closeDialog();
			}
	
	}

}
