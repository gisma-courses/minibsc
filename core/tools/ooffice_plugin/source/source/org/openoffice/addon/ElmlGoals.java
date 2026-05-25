package org.openoffice.addon;

import com.sun.star.beans.XPropertySet;
import com.sun.star.container.XEnumeration;
import com.sun.star.lang.XServiceInfo;
import com.sun.star.text.XRelativeTextContentInsert;
import com.sun.star.text.XTextContent;
import com.sun.star.uno.Exception;
import com.sun.star.uno.UnoRuntime;

public class ElmlGoals extends Elements {
	
	public int popupDialog = 0;
	
	public ElmlGoals() {
	}

	public void addContent(String label, String title, String navTitle) {
		try {
			xParaCursor.gotoStartOfParagraph(false);

			XTextContent xSection = xContentFactory.createSection("goals", 1);
			xText.insertTextContent(xParaCursor, xSection, false);

			// jump back into section
			xParaCursor.gotoPreviousParagraph(false);

			// insert title
			xParaCursor.setString(title);

			// access the property set of the cursor selection
			XPropertySet xCursorProps = (XPropertySet) UnoRuntime
					.queryInterface(XPropertySet.class, xParaCursor);

			// set the style of the cursor selection to a new style
			xCursorProps.setPropertyValue("ParaStyleName", "ElmlGoals");

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
		xContentAccess.setSectionName(attrLabel, label);
		xContentAccess.setStringPortion(attrTitle, title);
	}

	public void setContent() {
		if (popupDialog == 1) {
			try {
				createDialog("", "", "");
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else {
			addContent("", "Lernziele", "");
		}
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
		createDialog(elementTitle, elementLabel, "");
	}

	public void getDepending() {

	}

	public void validate() {

	}

	public void createDialog(String elementTitle, String elementLabel,
			String elementNavTitle) throws Exception {
		xDialogController = new DialogController(this);
		xDialogController.setWindowProperties("Goals", 100, 100, 170, 140);
		xDialogController.showDialog();
	}
	
	public void validateInput() {
		if (ModeSet == MODE_NEW) {
			addContent(attrLabelValue, attrTitleValue, attrNavTitleValue);
			xDialogController.closeDialog();
		} else if (ModeSet == MODE_EDIT) {
			editContent(attrLabelValue, attrTitleValue, attrNavTitleValue);
			xDialogController.closeDialog();
		}
	}
}
