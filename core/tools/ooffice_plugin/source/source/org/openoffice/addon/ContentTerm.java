package org.openoffice.addon;

import java.awt.Frame;
import java.util.Vector;

import com.sun.star.beans.XPropertySet;
import com.sun.star.container.XEnumeration;
import com.sun.star.container.XIndexAccess;
import com.sun.star.frame.XModel;
import com.sun.star.lang.IndexOutOfBoundsException;
import com.sun.star.lang.WrappedTargetException;
import com.sun.star.lang.XComponent;
import com.sun.star.lang.XMultiComponentFactory;
import com.sun.star.lang.XMultiServiceFactory;
import com.sun.star.lang.XServiceInfo;
import com.sun.star.text.XParagraphCursor;
import com.sun.star.text.XRelativeTextContentInsert;
import com.sun.star.text.XText;
import com.sun.star.text.XTextContent;
import com.sun.star.text.XTextDocument;
import com.sun.star.text.XTextRange;
import com.sun.star.text.XTextSection;
import com.sun.star.text.XTextViewCursorSupplier;
import com.sun.star.uno.Exception;
import com.sun.star.uno.UnoRuntime;

public class ContentTerm extends Elements {

	private Vector ListBoxEntries;

	private String[] contentTerms;

	private XText cellText;

	public ContentTerm() {
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
			XTextRange xTableRange = null;
			try {
				xTableRange = ( XTextRange ) UnoRuntime.queryInterface (
						 XTextRange.class, xRangeAccess.getByIndex(0) );
			} catch (IndexOutOfBoundsException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (WrappedTargetException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			cellText = xTableRange.getText();
		}
		

		xModelCursor = cellText.createTextCursorByRange(xViewCursor.getEnd());
		xParaCursor = (XParagraphCursor) UnoRuntime.queryInterface(
				XParagraphCursor.class, xModelCursor);
		setMode(mode);

		xContentFactory = new ContentFactory();
		xContentAccess = new ContentAccess();
		xContentContext = new ContentContext();

	}

	public void setContent() {
		if (popupDialog == 1) {

			ListBoxEntries = new Vector();
			contentTerms = null;

			xModelCursor = xText.createTextCursorByRange(xText.getStart());
			xParaCursor = (XParagraphCursor) UnoRuntime.queryInterface(
					XParagraphCursor.class, xModelCursor);
			xParaCursor.gotoStart(false);
			
			try {
				//TODO: Stop Endlosschlaufe!
				while (!xContentContext.getContext(xParaCursor).equals(
						"ElmlGlossary")) {
					xParaCursor.gotoNextParagraph(false); // go to glossary
				}
				
				xParaCursor.gotoNextParagraph(false);

				while (!xContentContext.getContext(xParaCursor).equals(
						"ElmlBibliography")) {

					XTextSection glossarEntry = xContentAccess
							.getSection(xParaCursor);
					Object string = xContentAccess.getSectionName(glossarEntry);
					ListBoxEntries.addElement(string);
					xParaCursor.gotoNextParagraph(false); // go to next
															// definition
				}

				if (ListBoxEntries.size() > 0) {
					int size = ListBoxEntries.size();
					contentTerms = new String[size];
					contentTerms = (String[]) ListBoxEntries
							.toArray(new String[0]);
				}

				createDialog("", "", "");
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else {
			addContent("", "", "");
		}
	}

	public void addContent(String label, String title, String navTitle) {
		try {
			
			XPropertySet xCursorProps = (XPropertySet) UnoRuntime
					.queryInterface(XPropertySet.class, xViewCursor);

			xCursorProps.setPropertyValue("HyperLinkURL", "#" + label
					+ "|region");
			xCursorProps.setPropertyValue("HyperLinkName", "ElmlTerm");
			xCursorProps.setPropertyValue("UnvisitedCharStyleName", "ElmlTerm");
			xCursorProps.setPropertyValue("VisitedCharStyleName", "ElmlTerm");

			xModelCursor = xText.createTextCursorByRange(xText.getStart());
			xParaCursor = (XParagraphCursor) UnoRuntime.queryInterface(
					XParagraphCursor.class, xModelCursor);
			
			xParaCursor.gotoRange(xParaCursor.getEnd(), false);
			if (!ListBoxEntries.contains(label)) {

				while (!xContentContext.getContext(xParaCursor).equals(
						"ElmlGlossary")) {
					xParaCursor.gotoNextParagraph(false);
				}

				XTextContent xSection = xContentFactory.createSection(label, 1);

				XRelativeTextContentInsert xRelative = (XRelativeTextContentInsert) UnoRuntime
						.queryInterface(XRelativeTextContentInsert.class, xText);

				XTextSection currentSection = xContentAccess
						.getSection(xParaCursor);
				XTextContent currentTextContent = (XTextContent) UnoRuntime
						.queryInterface(XTextContent.class, currentSection);

				XTextContent xNewPara = (XTextContent) UnoRuntime
						.queryInterface(XTextContent.class, mxDocFactory
								.createInstance("com.sun.star.text.Paragraph"));

				xRelative.insertTextContentAfter(xNewPara, currentTextContent);

				xParaCursor.gotoNextParagraph(false);
				xText.insertTextContent(xParaCursor, xSection, false);
				xParaCursor.gotoPreviousParagraph(false);
				xText.removeTextContent(xNewPara);
				xParaCursor.setString(label + ": " + title);

				XPropertySet xCursorProps1 = (XPropertySet) UnoRuntime
						.queryInterface(XPropertySet.class, xParaCursor);
				xCursorProps1.setPropertyValue("ParaStyleName",
						"ElmlDefinition");
			}
		} catch (java.lang.Exception e) {
			e.printStackTrace(System.out);
		}
	}

	public void editContent(String label, String title, String navTitle) {
		xContentAccess.setTextFieldName(attrNavTitle, navTitle);
		xContentAccess.setSectionName(attrLabel, label);
		xContentAccess.setStringPortion(attrTitle, label + ": " + title);
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
		elementTitle = xContentAccess.getSectionName(attrLabel);

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
							elementLabel = xContentAccess
									.getStringPortion(attrTitle);
							int splitter = elementLabel.indexOf(":");
							elementLabel = elementLabel.substring(splitter + 2);
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
		xDialogController.setWindowProperties("Glossar", 100, 100, 170, 140);

		/* ---- LABELS ---- */
		Object title = xDialogController.createLabel("titleLabel", "[@term]",
				10, 10, 150, 14, (short) 0, false);
		xDialogController.addElement("titleLabel", title);

		Object label = xDialogController.createLabel("labelLabel",
				"[definition]", 10, 45, 150, 14, (short) 0, false);
		xDialogController.addElement("labelLabel", label);

		/* ---- TEXTFIELDS ---- */
		boolean status = true;
		if (ModeSet == MODE_EDIT) {
			status = false;
		}
		Object titleTxt = xDialogController.createComboBox("term",
				elementTitle, 10, 25, 150, 14, (short) 1, false, (short) 0,
				contentTerms, status);
		xDialogController.addElement("term", titleTxt);

		Object labelTxt = xDialogController.createTextField("definition",
				elementLabel, 10, 60, 150, 50, (short) 2, true, (short) 0);
		xDialogController.addElement("definition", labelTxt);

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
		attrLabelValue = xDialogController.getControlText("term");
		attrTitleValue = xDialogController.getControlText("definition");

		if (attrLabelValue.equals("")) {
			validator.validateInput("term");
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
