package org.openoffice.addon;

import com.sun.star.beans.XPropertySet;
import com.sun.star.container.XEnumeration;
import com.sun.star.lang.XServiceInfo;
import com.sun.star.text.XRelativeTextContentInsert;
import com.sun.star.text.XTextContent;
import com.sun.star.text.XTextSection;
import com.sun.star.uno.Exception;
import com.sun.star.uno.UnoRuntime;

public class ElmlUnit extends Elements {

	public ElmlUnit() {
	}

	public void addContent(String label, String title, String navTitle) {
		try {
			xParaCursor.gotoStartOfParagraph(false);
			XTextContent xSection = xContentFactory.createSection(label, 1);

			XRelativeTextContentInsert xRelative = (XRelativeTextContentInsert) UnoRuntime
					.queryInterface(XRelativeTextContentInsert.class, xText);

			XTextSection currentSection = xContentAccess
					.getSection(xParaCursor);
			XTextContent currentTextContent = (XTextContent) UnoRuntime
					.queryInterface(XTextContent.class, currentSection);

			XTextContent xNewPara = (XTextContent) UnoRuntime.queryInterface(
					XTextContent.class, mxDocFactory
							.createInstance("com.sun.star.text.Paragraph"));

			if (currentTextContent != null) {
				xRelative.insertTextContentBefore(xNewPara, currentTextContent);
				xParaCursor.gotoPreviousParagraph(false);
				xText.insertTextContent(xParaCursor, xSection, false);
				xText.removeTextContent(xNewPara);
				xParaCursor.gotoNextParagraph(false);
				xParaCursor.gotoPreviousParagraph(false);
			} else {
				xText.insertTextContent(xParaCursor, xSection, false);
				xParaCursor.gotoPreviousParagraph(false);
			}

			XPropertySet xCursorProps = (XPropertySet) UnoRuntime
					.queryInterface(XPropertySet.class, xParaCursor);

			xCursorProps.setPropertyValue("ParaStyleName", "ElmlUnit");

			xParaCursor.setString(title);

			XTextContent xAttribute = xContentFactory.createTextField(
					"navTitle", navTitle);
			xText.insertTextContent(xParaCursor, xAttribute, false);

			// Add element tag
			xParaCursor.gotoEndOfParagraph(false);
			xCursorProps.setPropertyValue("CharStyleName", "ElmlBlank");
			xParaCursor.setString("     <unit>");

		} catch (java.lang.Exception e) {
			e.printStackTrace(System.out);
		}

	}

	public void editContent(String label, String title, String navTitle) {
		xContentAccess.setTextFieldName(attrNavTitle, navTitle);
		xContentAccess.setSectionName(attrLabel, label);
		xContentAccess.setStringPortion(attrTitle, title);
	}

	public void getContent() throws Exception {
		String elementTitle = "";
		String elementLabel = "";
		String elementNavTitle = "";
		Object Element = null;
		Object Portion = null;
		XEnumeration xSectEnum = null;
		XEnumeration xParaEnum = null;

		// Get the section name
		attrLabel = xContentAccess.getSection(xParaCursor);
		elementLabel = xContentAccess.getSectionName(attrLabel);

		xSectEnum = xContentAccess.createInnerSectionEnum(attrLabel);

		// While there is content inside the section, enumerate it
		while (xSectEnum.hasMoreElements()) {
			Element = xSectEnum.nextElement();
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
							attrNavTitle = xContentAccess.getTextField(Portion);
							elementNavTitle = xContentAccess
									.getTextFieldName(attrNavTitle);
						} else if (portionType.equals("Text") && !firstContact) {
							attrTitle = xContentAccess.getText(Portion);
							elementTitle = xContentAccess
									.getStringPortion(attrTitle);
							firstContact = true;
						} else {

						}
					}
				}
			}
		}
		createDialog(elementTitle, elementLabel, elementNavTitle);
	}

	public void getDepending() {
		if (ModeSet != MODE_CANCEL) {
			ElementController.createElement("ElmlEntry");
			ElementController.createElement("ElmlGoals");
		}
	}

	public void createDialog(String elementTitle, String elementLabel,
			String elementNavTitle) throws Exception {
		xDialogController = new DialogController(this);
		xDialogController.setWindowProperties("Unit", 100, 100, 170, 140);

		/* ---- LABELS ---- */
		Object title = xDialogController.createLabel("titleLabel",
				"Titel der Unit: [@title]", 10, 10, 150, 14, (short) 0, false);
		xDialogController.addElement("titleLabel", title);

		Object label = xDialogController.createLabel("labelLabel",
				"Interne Bezeichnung der Unit: [@label]", 10, 45, 150, 14,
				(short) 0, false);
		xDialogController.addElement("labelLabel", label);

		Object navTitle = xDialogController.createLabel("navTitleLabel",
				"Navigationstitel: [@navTitle]", 10, 80, 150, 14, (short) 0,
				false);
		xDialogController.addElement("navTitleLabel", navTitle);

		/* ---- TEXTFIELDS ---- */
		Object titleTxt = xDialogController.createTextField("title",
				elementTitle, 10, 25, 150, 14, (short) 1, false, (short) 0);
		xDialogController.addElement("title", titleTxt);

		Object labelTxt = xDialogController.createTextField("label",
				elementLabel, 10, 60, 150, 14, (short) 2, false, (short) 0);
		xDialogController.addElement("label", labelTxt);

		Object navTitleTxt = xDialogController.createTextField("navTitle",
				elementNavTitle, 10, 95, 150, 14, (short) 3, false, (short) 0);
		xDialogController.addElement("navTitle", navTitleTxt);

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
		Validator validator = new Validator();
		attrNavTitleValue = xDialogController.getControlText("navTitle");
		attrLabelValue = xDialogController.getControlText("label");
		attrTitleValue = xDialogController.getControlText("title");

		if (attrTitleValue.equals("") && attrLabelValue.equals("")) {
			validator.validateInput("title_label");
		} else if (attrTitleValue.equals("")) {
			validator.validateInput("title");
		} else if (attrLabelValue.equals("")) {
			validator.validateInput("label");
		} else {
			if (ModeSet == MODE_NEW) {
				addContent(attrLabelValue, attrTitleValue, attrNavTitleValue);
				xDialogController.closeDialog();
			} else if (ModeSet == MODE_EDIT) {
				editContent(attrLabelValue, attrTitleValue, attrNavTitleValue);
				xDialogController.closeDialog();
			}
		}
	}

}
