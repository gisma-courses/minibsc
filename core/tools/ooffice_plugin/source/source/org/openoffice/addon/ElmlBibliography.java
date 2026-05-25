package org.openoffice.addon;

import java.awt.Frame;

import com.sun.star.beans.XPropertySet;
import com.sun.star.container.XEnumeration;
import com.sun.star.lang.XServiceInfo;
import com.sun.star.style.BreakType;
import com.sun.star.text.XDependentTextField;
import com.sun.star.text.XTextContent;
import com.sun.star.text.XTextRange;
import com.sun.star.uno.Exception;
import com.sun.star.uno.UnoRuntime;

public class ElmlBibliography extends Elements {

	public int popupDialog = 0;

	private boolean visAll;

	private boolean visOnline;

	private boolean visPrint;

	private boolean visNone;

	private Object attribute;

	private Object attrSorting;

	private String sortingAtt;

	private boolean sortOff;

	private boolean sortAuthor;

	private boolean sortYear;

	private boolean sortGroupYear;

	private boolean sortGroupType;

	private String elementSorting;

	public static String BIBLIOGRAPHY_TITLE = "Bibliographie";

	public static String BIBLIOGRAPHY_LABEL = "bibliography";

	public ElmlBibliography() {
	}

	public void setContent() {
		if (popupDialog == 1) {
			try {
				createDialog("", "", "");
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else {
			addContent(BIBLIOGRAPHY_LABEL, BIBLIOGRAPHY_TITLE, "");
		}
	}

	public void addContent(String label, String title, String navTitle) {
		try {

			// access the property set of the cursor selection
			XPropertySet xCursorProps = (XPropertySet) UnoRuntime
					.queryInterface(XPropertySet.class, xParaCursor);

			xParaCursor.gotoEnd(false);
			xCursorProps.setPropertyValue("BreakType", BreakType.PAGE_BEFORE);
			xParaCursor.gotoEnd(false);
			
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
			XTextContent xAttrOff = xContentFactory.createTextField(
					"sorting", "off");
			xText.insertTextContent(xParaCursor, xAttrOff, false);

			// set the style of the cursor selection to a new style
			xCursorProps.setPropertyValue("ParaStyleName", "ElmlBibliography");
			
			xParaCursor.gotoPreviousParagraph(false);
			xParaCursor.gotoPreviousParagraph(false);
			XTextRange endOfPage = xParaCursor.getEnd();
			xViewCursor.gotoRange(endOfPage, false);

		} catch (java.lang.Exception e) {
			e.printStackTrace(System.out);
		}
	}

	public void editContent(String label, String title, String navTitle) {
		xContentAccess.setTextFieldName(attrNavTitle, navTitle);
		xContentAccess.setTextFieldName(attrSorting, label);
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
							
							attribute = xContentAccess.getTextField(Portion);
							XDependentTextField xField = (XDependentTextField) UnoRuntime.queryInterface(
									XDependentTextField.class, attribute);
							XPropertySet xMaster = xField.getTextFieldMaster();
							String name = (String) xMaster.getPropertyValue("Name");
							
							if (name.equals("visible")) {
								attrNavTitle = xContentAccess.getTextField(Portion);
								elementNavTitle = xContentAccess
										.getTextFieldName(attrNavTitle);
							} else if (name.equals("sorting")) {
								attrSorting = xContentAccess.getTextField(Portion);
								elementSorting = xContentAccess
										.getTextFieldName(attrSorting);
							}
							
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
		xDialogController.setWindowProperties("Bibliographie", 100, 140, 170, 160);

		/* ---- LABELS ---- */
		Object title = xDialogController.createLabel("titleLabel",
				"Sichtbarkeit der Bibliographie: [@visible]", 10, 10, 150, 14,
				(short) 0, false);
		xDialogController.addElement("titleLabel", title);
		
		Object sorting = xDialogController.createLabel("sortingLabel",
				"Sortierung: [@sorting]", 10, 45, 150, 14,
				(short) 19, false);
		xDialogController.addElement("sortingLabel", sorting);

		if (elementNavTitle.equals("")) {
			elementNavTitle = "all";
		}
		/* ---- CHECKBOX VISIBILITY---- */
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
		
		/* ---- CHECKBOX SORTING---- */
		if (elementSorting.equals("")) {
			elementLabel = "off";
		}
		if (elementSorting.equals("off")) {
			Object sortOff = xDialogController.createRadioButton("sortOff",
					"off", 10, 60, 30, 14, false, (short) 1, (short) 20, true);
			xDialogController.addElement("sortOff", sortOff);
		} else {
			Object sortOff = xDialogController.createRadioButton("sortOff",
					"off", 10, 60, 30, 14, false, (short) 0, (short) 20, true);
			xDialogController.addElement("sortOff", sortOff);
		}
		if (elementSorting.equals("byAuthor")) {
			Object sortAuthor = xDialogController.createRadioButton("sortAuthor",
					"byAuthor", 10, 75, 80, 14, false, (short) 1, (short) 21, true);
			xDialogController.addElement("sortAuthor", sortAuthor);
		} else {
			Object sortAuthor = xDialogController.createRadioButton("sortAuthor",
					"byAuthor", 10, 75, 80, 14, false, (short) 0, (short) 21, true);
			xDialogController.addElement("sortAuthor", sortAuthor);
		}
		if (elementSorting.equals("byYear")) {
			Object sortYear = xDialogController.createRadioButton("sortYear",
					"byYear", 10, 90, 60, 14, false, (short) 1, (short) 22, true);
			xDialogController.addElement("sortYear", sortYear);
		} else {
			Object sortYear = xDialogController.createRadioButton("sortYear",
					"byYear", 10, 90, 60, 14, false, (short) 0, (short) 22, true);
			xDialogController.addElement("sortYear", sortYear);
		}
		if (elementSorting.equals("groupByYear")) {
			Object sortGroupYear = xDialogController.createRadioButton("sortGroupYear",
					"groupByYear", 10, 105, 80, 14, false, (short) 1, (short) 23, true);
			xDialogController.addElement("sortGroupYear", sortGroupYear);
		} else {
			Object sortGroupYear = xDialogController.createRadioButton("sortGroupYear",
					"groupByYear", 10, 105, 80, 14, false, (short) 0, (short) 23, true);
			xDialogController.addElement("sortGroupYear", sortGroupYear);
		}
		if (elementSorting.equals("groupByType")) {
			Object sortGroupType = xDialogController.createRadioButton("sortGroupType",
					"groupByType", 10, 120, 80, 14, false, (short) 1, (short) 24, true);
			xDialogController.addElement("sortGroupType", sortGroupType);
		} else {
			Object sortGroupType = xDialogController.createRadioButton("sortGroupType",
					"groupByType", 10, 120, 80, 14, false, (short) 0, (short) 24, true);
			xDialogController.addElement("sortGroupType", sortGroupType);
		}
		

		/* ---- BUTTONS ---- */
		Object buttonOK = xDialogController.createButton("ok", "OK", 110, 140,
				50, 14, (short) 4);
		xDialogController.addElement("ok", buttonOK);
		xDialogController.attachActionListener("ok");

		Object buttonCancel = xDialogController.createButton("cancel",
				"Abbrechen", 55, 140, 50, 14, (short) 5);
		xDialogController.addElement("cancel", buttonCancel);
		xDialogController.attachActionListener("cancel");

		xDialogController.showDialog();
	}

	public void validateInput() {
		visibilityAtt = null;
		sortingAtt = null;
		visAll = xDialogController.getControlState("visAll");
		visOnline = xDialogController.getControlState("visOnline");
		visPrint = xDialogController.getControlState("visPrint");
		visNone = xDialogController.getControlState("visNone");
		
		sortOff = xDialogController.getControlState("sortOff");
		sortAuthor = xDialogController.getControlState("sortAuthor");
		sortYear = xDialogController.getControlState("sortYear");
		sortGroupYear = xDialogController.getControlState("sortGroupYear");
		sortGroupType = xDialogController.getControlState("sortGroupType");

		if (visNone) {
			visibilityAtt = "none";
		} else if (visOnline) {
			visibilityAtt = "online";
		} else if (visPrint) {
			visibilityAtt = "print";
		} else {
			visibilityAtt = "all";
		}
		if (sortOff) {
			sortingAtt = "off";
		} else if (sortAuthor) {
			sortingAtt = "byAuthor";
		} else if (sortYear) {
			sortingAtt = "byYear";
		} else if (sortGroupYear) {
			sortingAtt = "groupByYear";
		} else if (sortGroupType) {
			sortingAtt = "groupByType";
		}
		
		if (ModeSet == MODE_NEW) {
			addContent(sortingAtt, attrTitleValue, visibilityAtt);
			xDialogController.closeDialog();
		} else if (ModeSet == MODE_EDIT) {
			editContent(sortingAtt, attrTitleValue, visibilityAtt);
			xDialogController.closeDialog();
		}
	}
}
