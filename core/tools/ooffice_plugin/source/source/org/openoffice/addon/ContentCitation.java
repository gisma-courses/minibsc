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

public class ContentCitation extends Elements {

	private Vector ListBoxEntries;

	private String[] bibEntries;

	private XText cellText;

	public ContentCitation() {
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
			bibEntries = null;

			xModelCursor = xText.createTextCursorByRange(xText.getStart());
			xParaCursor = (XParagraphCursor) UnoRuntime.queryInterface(
					XParagraphCursor.class, xModelCursor);
			xParaCursor.gotoStart(false);
			
			try {
				//TODO: Stop Endlosschlaufe!
				while (!xContentContext.getContext(xParaCursor).equals(
						"ElmlBibliography")) {
					xParaCursor.gotoNextParagraph(false); // go to bibliiography
				}

				while (xParaCursor.gotoNextParagraph(false)) {

					XTextSection bibEntry = xContentAccess
							.getSection(xParaCursor);
					Object string = xContentAccess.getSectionName(bibEntry);
					ListBoxEntries.addElement(string);
				}

				if (ListBoxEntries.size() > 0) {
					int size = ListBoxEntries.size();
					bibEntries = new String[size];
					bibEntries = (String[]) ListBoxEntries
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

			xCursorProps.setPropertyValue("CharStyleName", "ElmlCitation");

			xParaCursor = (XParagraphCursor) UnoRuntime.queryInterface(
					XParagraphCursor.class, xViewCursor.getEnd());
			xViewCursor.collapseToEnd();
			
			xCursorProps.setPropertyValue("CharStyleName", "ElmlBlank");
			xViewCursor.setString(" (");
			xViewCursor.collapseToEnd();
			xCursorProps.setPropertyValue("CharStyleName", "ElmlCitationRef");
			xViewCursor.setString(label);
			xViewCursor.collapseToEnd();
			xCursorProps.setPropertyValue("CharStyleName", "ElmlBlank");
			xViewCursor.setString(")");
			xViewCursor.collapseToEnd();
			xCursorProps.setPropertyValue("CharStyleName", "Standard");
			xViewCursor.setString(" ");
			xViewCursor.collapseToEnd();
			
		} catch (java.lang.Exception e) {
			e.printStackTrace(System.out);
		}
	}

	public void editContent(String label, String title, String navTitle) {

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
		xDialogController.setWindowProperties("Citation", 100, 100, 170, 140);

		/* ---- LABELS ---- */
		Object title = xDialogController.createLabel("titleLabel", "[@bibIDRef]",
				10, 10, 150, 14, (short) 0, false);
		xDialogController.addElement("titleLabel", title);

		/* ---- TEXTFIELDS ---- */
		boolean status = true;
		if (ModeSet == MODE_EDIT) {
			status = false;
		}
		Object txttype = xDialogController.createListBox("type", (short)0, 10,
				25, 150, 14, (short) 1, false, (short) 5, bibEntries, true);
		xDialogController.addElement("bibIDRef", txttype);

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
		attrLabelValue = xDialogController.getSelectedText("bibIDRef");

		if (attrLabelValue.equals("")) {
			validator.validateInput("bibIDRef");
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
