package org.openoffice.addon;

import java.awt.Frame;

import com.sun.star.beans.XPropertySet;
import com.sun.star.container.XEnumeration;
import com.sun.star.lang.XServiceInfo;
import com.sun.star.style.BreakType;
import com.sun.star.text.XRelativeTextContentInsert;
import com.sun.star.text.XTextContent;
import com.sun.star.uno.Exception;
import com.sun.star.uno.UnoRuntime;

public class ElmlGlossary extends Elements {

	public int popupDialog = 0;

	private boolean visAll;

	private boolean visOnline;

	private boolean visPrint;

	private boolean visNone;

	public static String GLOSSARY_TITLE = "Glossar";

	public static String GLOSSARY_LABEL = "glossary";

	public ElmlGlossary() {
	}

	public void setContent() {
		if (popupDialog == 1) {
			try {
				createDialog("", "", "");
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else {
			addContent(GLOSSARY_LABEL, GLOSSARY_TITLE, "");
		}
	}

	public void addContent(String label, String title, String navTitle) {
		try {

			// access the property set of the cursor selection
			XPropertySet xCursorProps = (XPropertySet) UnoRuntime
					.queryInterface(XPropertySet.class, xViewCursor);

			xParaCursor.gotoEnd(false);
			xCursorProps.setPropertyValue("BreakType", BreakType.PAGE_BEFORE);

			// create new TextSection with factory
			XTextContent xSection = xContentFactory.createSection(label, 1);
			xText.insertTextContent(xParaCursor, xSection, false);

			// jump back into section
			xParaCursor.gotoPreviousParagraph(true);

			// insert title
			xParaCursor.setString(title);

			XTextContent xAttribute = xContentFactory.createTextField(
					"visible", navTitle);
			xText.insertTextContent(xParaCursor, xAttribute, false);

			// set the style of the cursor selection to a new style
			xCursorProps.setPropertyValue("ParaStyleName", "ElmlGlossary");

			// Create a new empty paragraph and get it's XTextContent interface
			XTextContent xNewPara = (XTextContent) UnoRuntime.queryInterface(
					XTextContent.class, mxDocFactory
							.createInstance("com.sun.star.text.Paragraph"));

			// Get the XRelativeTextContentInsert interface
			XRelativeTextContentInsert xRelative = (XRelativeTextContentInsert) UnoRuntime
					.queryInterface(XRelativeTextContentInsert.class, xText);
			// Insert the empty paragraph after the TextSection
			xRelative.insertTextContentAfter(xNewPara, xSection);

		} catch (java.lang.Exception e) {
			e.printStackTrace(System.out);
		}
	}

	public void editContent(String label, String title, String navTitle) {
		xContentAccess.setTextFieldName(attrNavTitle, navTitle);
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
						} else if (portionType.equals("Text")) {
							attrTitle = xContentAccess.getText(Portion);
							elementTitle = xContentAccess
									.getStringPortion(attrTitle);
						} else {

						}
					}
				}
			}
		}

		createDialog(elementTitle, elementLabel, elementNavTitle);
	}

	public void getDepending() {
	}

	public void createDialog(String elementTitle, String elementLabel,
			String elementNavTitle) throws Exception {
		xDialogController = new DialogController(this);
		xDialogController.setWindowProperties("Glossary", 100, 100, 170, 80);

		/* ---- LABELS ---- */
		Object title = xDialogController.createLabel("titleLabel",
				"Sichtbarkeit des Glossars: [@visible]", 10, 10, 150, 14,
				(short) 0, false);
		xDialogController.addElement("titleLabel", title);

		if (elementNavTitle.equals("")) {
			elementNavTitle = "all";
		}
		/* ---- CHECKBOX ---- */
		if (elementNavTitle.equals("all")) {
			Object visAllTxt = xDialogController.createRadioButton("visAll",
					"all", 10, 25, 30, 14, false, (short) 1, (short) 10, true);
			xDialogController.addElement("visAll", visAllTxt);
		} else {
			Object visAllTxt = xDialogController.createRadioButton("visAll",
					"all", 10, 25, 30, 14, false, (short) 0, (short) 10, true);
			xDialogController.addElement("visAll", visAllTxt);
		}
		if (elementNavTitle.equals("online")) {
			Object visOnlineTxt = xDialogController.createRadioButton(
					"visOnline", "online", 40, 25, 30, 14, false, (short) 1,
					(short) 11, true);
			xDialogController.addElement("visOnline", visOnlineTxt);
		} else {
			Object visOnlineTxt = xDialogController.createRadioButton(
					"visOnline", "online", 40, 25, 30, 14, false, (short) 0,
					(short) 11, true);
			xDialogController.addElement("visOnline", visOnlineTxt);
		}
		if (elementNavTitle.equals("print")) {
			Object visPrintTxt = xDialogController.createRadioButton(
					"visPrint", "print", 80, 25, 30, 14, false, (short) 1,
					(short) 12, true);
			xDialogController.addElement("visPrint", visPrintTxt);
		} else {
			Object visPrintTxt = xDialogController.createRadioButton(
					"visPrint", "print", 80, 25, 30, 14, false, (short) 0,
					(short) 12, true);
			xDialogController.addElement("visPrint", visPrintTxt);
		}
		if (elementNavTitle.equals("none")) {
			Object visNoneTxt = xDialogController
					.createRadioButton("visNone", "none", 120, 25, 30, 14,
							false, (short) 1, (short) 13, true);
			xDialogController.addElement("visNone", visNoneTxt);
		} else {
			Object visNoneTxt = xDialogController
					.createRadioButton("visNone", "none", 120, 25, 30, 14,
							false, (short) 0, (short) 13, true);
			xDialogController.addElement("visNone", visNoneTxt);
		}

		/* ---- BUTTONS ---- */
		Object buttonOK = xDialogController.createButton("ok", "OK", 110, 55,
				50, 14, (short) 4);
		xDialogController.addElement("ok", buttonOK);
		xDialogController.attachActionListener("ok");

		Object buttonCancel = xDialogController.createButton("cancel",
				"Abbrechen", 55, 55, 50, 14, (short) 5);
		xDialogController.addElement("cancel", buttonCancel);
		xDialogController.attachActionListener("cancel");

		xDialogController.showDialog();
	}

	public void validateInput() {
		visibilityAtt = null;
		visAll = xDialogController.getControlState("visAll");
		visOnline = xDialogController.getControlState("visOnline");
		visPrint = xDialogController.getControlState("visPrint");
		visNone = xDialogController.getControlState("visNone");

		if (visNone) {
			visibilityAtt = "none";
		} else if (visOnline) {
			visibilityAtt = "online";
		} else if (visPrint) {
			visibilityAtt = "print";
		} else {
			visibilityAtt = "all";
		}
		if (ModeSet == MODE_NEW) {
			addContent(attrLabelValue, attrTitleValue, attrNavTitleValue);
			xDialogController.closeDialog();
		} else if (ModeSet == MODE_EDIT) {
			editContent(attrLabelValue, attrTitleValue, visibilityAtt);
			xDialogController.closeDialog();
		}

	}
}
