package org.openoffice.addon;

import com.sun.star.beans.XPropertySet;
import com.sun.star.container.XEnumeration;
import com.sun.star.lang.XServiceInfo;
import com.sun.star.text.XRelativeTextContentInsert;
import com.sun.star.text.XTextContent;
import com.sun.star.uno.Exception;
import com.sun.star.uno.UnoRuntime;

public class ElmlEntry extends Elements {

	public int popupDialog = 0;

	private static String ENTRY_TITLE = "Einführung";

	private static String ENTRY_LABEL = "entry";

	public ElmlEntry() {
	}

	public void setContent() {
		if (popupDialog == 1) {
			try {
				createDialog("", "", "");
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else {
			addContent("", ENTRY_TITLE, "");
		}
	}

	public void addContent(String label, String title, String navTitle) {
		try {
			xParaCursor.gotoStartOfParagraph(false);

			XTextContent xSection = xContentFactory.createSection(ENTRY_LABEL,
					1);
			xText.insertTextContent(xParaCursor, xSection, false);

			// access the property set of the cursor selection
			XPropertySet xCursorProps = (XPropertySet) UnoRuntime
					.queryInterface(XPropertySet.class, xParaCursor);

			// jump back into section
			xParaCursor.gotoPreviousParagraph(false);

			// set the style of the cursor selection to a new style
			xCursorProps.setPropertyValue("ParaStyleName", "ElmlEntry");

			// insert title
			xParaCursor.setString(title);

			// Get the XRelativeTextContentInsert interface
			XRelativeTextContentInsert xRelative = (XRelativeTextContentInsert) UnoRuntime
					.queryInterface(XRelativeTextContentInsert.class, xText);

			// Create a new empty paragraph and get it's XTextContent interface
			XTextContent xNewPara = (XTextContent) UnoRuntime.queryInterface(
					XTextContent.class, mxDocFactory
							.createInstance("com.sun.star.text.Paragraph"));

			// Insert the empty paragraph after the TextSection
			xRelative.insertTextContentAfter(xNewPara, xSection);

			xParaCursor.gotoNextParagraph(false);
			xText.insertString(xParaCursor, "[Text]", false);

			// Access the property set of the cursor selection
			xCursorProps = (XPropertySet) UnoRuntime.queryInterface(
					XPropertySet.class, xParaCursor);

			// Set the style of the cursor selection to a new style
			xCursorProps.setPropertyValue("ParaStyleName", "ElmlParagraph");

		} catch (java.lang.Exception e) {
			e.printStackTrace(System.out);
		}
	}

	public void editContent(String label, String title, String navTitle) {
		if (!label.equals("")) {
			xContentAccess.setSectionName(attrLabel, label);
		}
		xContentAccess.setStringPortion(attrTitle, title);
	}

	public void getContent() throws Exception {
		String elementTitle = "";
		String elementLabel = "";
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
		createDialog(elementTitle, elementLabel, "");
	}

	public void createDialog(String elementTitle, String elementLabel,
			String elementNavTitle) throws Exception {
		xDialogController = new DialogController(this);
		xDialogController.setWindowProperties("Entry", 100, 100, 170, 140);

		if (elementLabel.startsWith("Bereich")) {
			elementLabel = "";
		} else if (elementLabel.startsWith("TextSection")) {
			elementLabel = "";
		}

		/* ---- LABELS ---- */
		Object title = xDialogController.createLabel("titleLabel",
				"Titel der Lektion: [@title]", 10, 10, 150, 14, (short) 0,
				false);
		xDialogController.addElement("titleLabel", title);

		Object label = xDialogController.createLabel("labelLabel",
				"Interne Bezeichnung der Lektion: [@label]", 10, 45, 150, 14,
				(short) 0, false);
		xDialogController.addElement("labelLabel", label);

		/* ---- TEXTFIELDS ---- */
		Object titleTxt = xDialogController.createTextField("title",
				elementTitle, 10, 25, 150, 14, (short) 1, false, (short) 0);
		xDialogController.addElement("title", titleTxt);

		Object labelTxt = xDialogController.createTextField("label",
				elementLabel, 10, 60, 150, 14, (short) 2, false, (short) 0);
		xDialogController.addElement("label", labelTxt);

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
		attrTitleValue = xDialogController.getControlText("title");

		if (attrTitleValue.equals("")) {
			attrTitleValue = ENTRY_TITLE;
		}

		if (ModeSet == MODE_NEW) {
			addContent(attrLabelValue, attrTitleValue, attrNavTitleValue);
			xDialogController.closeDialog();
		} else if (ModeSet == MODE_EDIT) {
			editContent(attrLabelValue, attrTitleValue, attrNavTitleValue);
			xDialogController.closeDialog();
		}
	}
}
