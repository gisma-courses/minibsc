package org.openoffice.addon;

import java.awt.Frame;
import java.util.Vector;

import com.sun.star.awt.XListBox;
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
import com.sun.star.style.TabAlign;
import com.sun.star.style.TabStop;
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

public class ElmlBibEntry extends Elements {

	private XText cellText;

	private String bibID = "";

	private String type = "";

	private String author = "";

	private String title = "";

	private String bookTitle = "";

	private String year = "";

	private String publisher = "";

	private String publicationPlace = "";

	private String edition = "";

	private String pageNr = "";

	private String editor = "";

	private String url = "";

	private String accessedDate = "";

	private String journalTitle = "";

	private String newspaperTitle = "";

	private String proceedingsTitle = "";

	private String volumeNr = "";

	private String productionPlace = "";

	private String productionOrganisation = "";

	private String contributionTitle = "";

	private short itemPos = 0;

	private Object attrAuthor;

	private Object attrYear;

	private Object attrBibTitle;

	private Object attrEdition;

	private Object attrPublicationPlace;

	private Object attrPublisher;

	private Object attrContributionTitle;

	private Object attrpageNr;

	private Object attrPageNr;

	private Object attrEditor;

	private Object attrUrl;

	private Object attrAcc;

	private Object attrAccessedDate;

	private Object attrVolumeNr;

	private Object attrProductionPlace;

	private Object attrProductionOrganisation;

	public ElmlBibEntry() {
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
				xTableRange = (XTextRange) UnoRuntime.queryInterface(
						XTextRange.class, xRangeAccess.getByIndex(0));
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
			try {
				createDialog("", "", "");
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} else {
			addContent("", "", "");
		}
	}

	public void addContent(String label, String title1, String navTitle) {
		try {
	
			xModelCursor = xText.createTextCursorByRange(xText.getStart());
			xParaCursor = (XParagraphCursor) UnoRuntime.queryInterface(
					XParagraphCursor.class, xModelCursor);

			xParaCursor.gotoRange(xParaCursor.getEnd(), false);

			while (!xContentContext.getContext(xParaCursor).equals(
					"ElmlBibliography")) {
				xParaCursor.gotoNextParagraph(false);
			}

			XTextContent xSection = xContentFactory.createSection(bibID, 1);

			XRelativeTextContentInsert xRelative = (XRelativeTextContentInsert) UnoRuntime
					.queryInterface(XRelativeTextContentInsert.class, xText);

			XTextSection currentSection = xContentAccess
					.getSection(xParaCursor);
			XTextContent currentTextContent = (XTextContent) UnoRuntime
					.queryInterface(XTextContent.class, currentSection);

			XTextContent xNewPara = (XTextContent) UnoRuntime.queryInterface(
					XTextContent.class, mxDocFactory
							.createInstance("com.sun.star.text.Paragraph"));

			xRelative.insertTextContentAfter(xNewPara, currentTextContent);

			XPropertySet xCursorProps1 = (XPropertySet) UnoRuntime
					.queryInterface(XPropertySet.class, xParaCursor);

			xParaCursor.gotoNextParagraph(false);
			xText.insertTextContent(xParaCursor, xSection, false);
			xParaCursor.gotoPreviousParagraph(false);
			xText.removeTextContent(xNewPara);
			
			/*
			TabStop[] tb = new TabStop[1];
			tb[0] = new TabStop();
			tb[0].Position = 3000;
			tb[0].FillChar = ' ';
			tb[0].Alignment = TabAlign.LEFT;

			xCursorProps1.setPropertyValue("ParaTabStops", tb);
			*/
			
			XTextContent xAttribute = xContentFactory.createTextField("type",
					type);
			xText.insertTextContent(xParaCursor, xAttribute, false);

			xCursorProps1.setPropertyValue("ParaStyleName", "ElmlBibEntry");
			
			// ADDING BIB ENTRY
			xParaCursor.setString("[" + bibID + "]	");
			xParaCursor.gotoEndOfParagraph(false);

			if (type.equals("Buch") || type.equals("Buchauszug")) {
				xCursorProps1
						.setPropertyValue("CharStyleName", "ElmlBibAuthor");
				xParaCursor.setString(author);
				xParaCursor.gotoEndOfParagraph(false);

				if (!year.equals("")) {
					xCursorProps1.setPropertyValue("CharStyleName", "ElmlBlank");

					xParaCursor.setString(" (");
					xParaCursor.gotoEndOfParagraph(false);

					xCursorProps1.setPropertyValue("CharStyleName",
							"ElmlBibYear");
					xParaCursor.setString(year);
					xParaCursor.gotoEndOfParagraph(false);

					xCursorProps1.setPropertyValue("CharStyleName", "ElmlBlank");
					xParaCursor.setString("). ");
					xParaCursor.gotoEndOfParagraph(false);
				} else {
					xCursorProps1.setPropertyValue("CharStyleName", "ElmlBlank");
					xParaCursor.setString(". ");
					xParaCursor.gotoEndOfParagraph(false);
				}

				if (!contributionTitle.equals("")) {
					xCursorProps1.setPropertyValue("CharStyleName",
							"ElmlBibContributionTitle");
					xParaCursor.setString(contributionTitle);
					xParaCursor.gotoEndOfParagraph(false);
					xCursorProps1.setPropertyValue("CharStyleName", "ElmlBlank");
					xParaCursor.setString(", ");
					xParaCursor.gotoEndOfParagraph(false);
				}

				xCursorProps1.setPropertyValue("CharStyleName", "ElmlBibTitle");
				xParaCursor.setString(title);
				xParaCursor.gotoEndOfParagraph(false);

				if (!edition.equals("")) {
					xCursorProps1.setPropertyValue("CharStyleName", "ElmlBlank");
					xParaCursor.setString(" (");
					xParaCursor.gotoEndOfParagraph(false);
					xCursorProps1.setPropertyValue("CharStyleName",
							"ElmlBibEdition");
					xParaCursor.setString(edition);
					xParaCursor.gotoEndOfParagraph(false);
					xCursorProps1.setPropertyValue("CharStyleName", "ElmlBlank");
					xParaCursor.setString(")");
					xParaCursor.gotoEndOfParagraph(false);
				}

				if (!pageNr.equals("")) {
					xCursorProps1.setPropertyValue("CharStyleName", "ElmlBlank");
					xParaCursor.setString(" (");
					xParaCursor.gotoEndOfParagraph(false);

					xCursorProps1.setPropertyValue("CharStyleName",
							"ElmlBibPageNr");
					xParaCursor.setString(pageNr);
					xParaCursor.gotoEndOfParagraph(false);

					xCursorProps1.setPropertyValue("CharStyleName", "ElmlBlank");
					xParaCursor.setString(")");
					xParaCursor.gotoEndOfParagraph(false);
				} else {
					xParaCursor.gotoEndOfParagraph(false);
				}

				xCursorProps1.setPropertyValue("CharStyleName", "ElmlBlank");
				xParaCursor.setString(". ");
				xParaCursor.gotoEndOfParagraph(false);

				xCursorProps1.setPropertyValue("CharStyleName",
						"ElmlBibPublicationPlace");
				xParaCursor.setString(publicationPlace);
				xParaCursor.gotoEndOfParagraph(false);

				xCursorProps1.setPropertyValue("CharStyleName", "ElmlBlank");
				xParaCursor.setString(": ");
				xParaCursor.gotoEndOfParagraph(false);

				xCursorProps1.setPropertyValue("CharStyleName",
						"ElmlBibPublisher");
				xParaCursor.setString(publisher);
				xParaCursor.gotoEndOfParagraph(false);

			} else if (type.equals("Artikel (Zeitschrift)")) {

				xCursorProps1
						.setPropertyValue("CharStyleName", "ElmlBibAuthor");
				xParaCursor.setString(author);
				xParaCursor.gotoEndOfParagraph(false);

				if (!year.equals("")) {
					xCursorProps1.setPropertyValue("CharStyleName", "ElmlBlank");
					xParaCursor.setString(" (");
					xParaCursor.gotoEndOfParagraph(false);

					xCursorProps1.setPropertyValue("CharStyleName",
							"ElmlBibYear");
					xParaCursor.setString(year);
					xParaCursor.gotoEndOfParagraph(false);

					xCursorProps1.setPropertyValue("CharStyleName", "ElmlBlank");
					xParaCursor.setString("). ");
					xParaCursor.gotoEndOfParagraph(false);
				} else {
					xCursorProps1.setPropertyValue("CharStyleName", "ElmlBlank");
					xParaCursor.setString(". ");
					xParaCursor.gotoEndOfParagraph(false);
				}

				if (!contributionTitle.equals("")) {
					xCursorProps1.setPropertyValue("CharStyleName",
							"ElmlBibContributionTitle");
					xParaCursor.setString(contributionTitle);
					xParaCursor.gotoEndOfParagraph(false);
					xCursorProps1.setPropertyValue("CharStyleName", "ElmlBlank");
					xParaCursor.setString(". ");
					xParaCursor.gotoEndOfParagraph(false);
				}

				xCursorProps1.setPropertyValue("CharStyleName", "ElmlBibTitle");
				xParaCursor.setString(title);
				xParaCursor.gotoEndOfParagraph(false);

				if (!volumeNr.equals("")) {
					xCursorProps1.setPropertyValue("CharStyleName", "ElmlBlank");
					xParaCursor.setString(", ");
					xParaCursor.gotoEndOfParagraph(false);
					xCursorProps1.setPropertyValue("CharStyleName",
							"ElmlBibVolumeNr");
					xParaCursor.setString(volumeNr);
					xParaCursor.gotoEndOfParagraph(false);
				}

				if (!pageNr.equals("")) {
					xCursorProps1.setPropertyValue("CharStyleName", "ElmlBlank");
					xParaCursor.setString(", ");
					xParaCursor.gotoEndOfParagraph(false);

					xCursorProps1.setPropertyValue("CharStyleName",
							"ElmlBibPageNr");
					xParaCursor.setString(pageNr);
					xParaCursor.gotoEndOfParagraph(false);

					xCursorProps1.setPropertyValue("CharStyleName", "ElmlBlank");
					xParaCursor.setString(".");
					xParaCursor.gotoEndOfParagraph(false);
				} else {
					xCursorProps1.setPropertyValue("CharStyleName", "ElmlBlank");
					xParaCursor.setString(".");
					xParaCursor.gotoEndOfParagraph(false);
				}

				xParaCursor.gotoEndOfParagraph(false);

			} else if (type.equals("Webseite")) {

				xCursorProps1
						.setPropertyValue("CharStyleName", "ElmlBibAuthor");
				xParaCursor.setString(author);
				xParaCursor.gotoEndOfParagraph(false);

				if (!year.equals("")) {
					xCursorProps1.setPropertyValue("CharStyleName", "ElmlBlank");
					xParaCursor.setString(" (");
					xParaCursor.gotoEndOfParagraph(false);

					xCursorProps1.setPropertyValue("CharStyleName",
							"ElmlBibYear");
					xParaCursor.setString(year);
					xParaCursor.gotoEndOfParagraph(false);

					xCursorProps1.setPropertyValue("CharStyleName", "ElmlBlank");
					xParaCursor.setString("). ");
					xParaCursor.gotoEndOfParagraph(false);
				} else {
					xCursorProps1.setPropertyValue("CharStyleName", "ElmlBlank");
					xParaCursor.setString(". ");
					xParaCursor.gotoEndOfParagraph(false);
				}

				xCursorProps1.setPropertyValue("CharStyleName", "ElmlBibTitle");
				xParaCursor.setString(title);
				xParaCursor.gotoEndOfParagraph(false);

				if (!edition.equals("")) {
					xCursorProps1.setPropertyValue("CharStyleName", "ElmlBlank");
					xParaCursor.setString(" (");
					xParaCursor.gotoEndOfParagraph(false);
					xCursorProps1.setPropertyValue("CharStyleName",
							"ElmlBibEdition");
					xParaCursor.setString(edition);
					xParaCursor.gotoEndOfParagraph(false);
					xCursorProps1.setPropertyValue("CharStyleName", "ElmlBlank");
					xParaCursor.setString(")");
					xParaCursor.gotoEndOfParagraph(false);
				}

				if (!publicationPlace.equals("")) {
					xCursorProps1.setPropertyValue("CharStyleName", "ElmlBlank");
					xParaCursor.setString(", ");
					xParaCursor.gotoEndOfParagraph(false);
					xCursorProps1.setPropertyValue("CharStyleName",
							"ElmlBibPublicationPlace");
					xParaCursor.setString(publicationPlace);
					xParaCursor.gotoEndOfParagraph(false);
				}
				if (!publisher.equals("")) {
					xCursorProps1.setPropertyValue("CharStyleName", "ElmlBlank");
					xParaCursor.setString(", ");
					xParaCursor.gotoEndOfParagraph(false);
					xCursorProps1.setPropertyValue("CharStyleName",
							"ElmlBibPublisher");
					xParaCursor.setString(publisher);
					xParaCursor.gotoEndOfParagraph(false);
				}

				xCursorProps1.setPropertyValue("CharStyleName", "ElmlBlank");
				xParaCursor.setString(", Available from ");
				xParaCursor.gotoEndOfParagraph(false);

				xCursorProps1.setPropertyValue("CharStyleName", "ElmlBibUrl");
				xParaCursor.setString(url);
				xParaCursor.gotoEndOfParagraph(false);

				if (!accessedDate.equals("")) {
					xCursorProps1.setPropertyValue("CharStyleName", "ElmlBlank");
					xParaCursor.setString(" [Accessed ");
					xParaCursor.gotoEndOfParagraph(false);

					xCursorProps1.setPropertyValue("CharStyleName",
							"ElmlBibAccessedDate");
					xParaCursor.setString(accessedDate);
					xParaCursor.gotoEndOfParagraph(false);

					xCursorProps1.setPropertyValue("CharStyleName", "ElmlBlank");
					xParaCursor.setString("].");
					xParaCursor.gotoEndOfParagraph(false);
				} else {
					xCursorProps1.setPropertyValue("CharStyleName", "ElmlBlank");
					xParaCursor.setString(".");
					xParaCursor.gotoEndOfParagraph(false);
				}

			}

		} catch (java.lang.Exception e) {
			e.printStackTrace(System.out);
		}
	}

	public void editContent(String label, String titleText, String navTitle) {
		xContentAccess.setTextFieldName(attrNavTitle, type);
		// xContentAccess.setSectionName(attrLabel, label);
		xContentAccess.setStringPortion(attrAuthor, author);
		xContentAccess.setStringPortion(attrYear, year);
		xContentAccess.setStringPortion(attrBibTitle, title);
		xContentAccess.setStringPortion(attrContributionTitle,
				contributionTitle);
		xContentAccess.setStringPortion(attrPublisher, publisher);
		xContentAccess.setStringPortion(attrPublicationPlace, publicationPlace);
		xContentAccess.setStringPortion(attrEdition, edition);
		xContentAccess.setStringPortion(attrPageNr, pageNr);
		xContentAccess.setStringPortion(attrEditor, editor);
		xContentAccess.setStringPortion(attrVolumeNr, volumeNr);
		xContentAccess.setStringPortion(attrUrl, url);
		xContentAccess.setStringPortion(attrAccessedDate, accessedDate);
		xContentAccess.setStringPortion(attrProductionPlace, productionPlace);
		xContentAccess.setStringPortion(attrProductionOrganisation,
				productionOrganisation);
	}

	public void getContent() throws Exception {
		String elementTitle = "";
		String elementLabel = "";
		String elementNavTitle = "";
		Object Element = null;
		Object Portion = null;
		XEnumeration xSectEnum = null;
		XEnumeration xParaEnum = null;
		boolean idCheck = false;

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

							type = elementNavTitle;

						} else if (portionType.equals("Text")) {
							attrTitle = xContentAccess.getText(Portion);
							elementLabel = xContentAccess
									.getStringPortion(attrTitle);

							XPropertySet StyleProp = (XPropertySet) UnoRuntime
									.queryInterface(XPropertySet.class,
											attrTitle);

							String charStyle = (String) StyleProp
									.getPropertyValue("CharStyleName");

							if (!idCheck) {
								bibID = elementTitle;
								idCheck = true;
							}
							if (charStyle.equals("ElmlBibAuthor")) {
								attrAuthor = attrTitle;
								author = elementLabel;
							} else if (charStyle.equals("ElmlBibYear")) {
								attrYear = attrTitle;
								year = elementLabel;
							} else if (charStyle.equals("ElmlBibTitle")) {
								attrBibTitle = attrTitle;
								title = elementLabel;
							} else if (charStyle.equals("ElmlBibEdition")) {
								attrEdition = attrTitle;
								edition = elementLabel;
							} else if (charStyle
									.equals("ElmlBibPublicationPlace")) {
								attrPublicationPlace = attrTitle;
								publicationPlace = elementLabel;
							} else if (charStyle.equals("ElmlBibPublisher")) {
								attrPublisher = attrTitle;
								publisher = elementLabel;
							} else if (charStyle
									.equals("ElmlBibContributionTitle")) {
								attrContributionTitle = attrTitle;
								contributionTitle = elementLabel;
							} else if (charStyle.equals("ElmlBibPageNr")) {
								attrPageNr = attrTitle;
								pageNr = elementLabel;
							} else if (charStyle.equals("ElmlBibEditor")) {
								attrEditor = attrTitle;
								editor = elementLabel;
							} else if (charStyle.equals("ElmlBibUrl")) {
								attrUrl = attrTitle;
								url = elementLabel;
							} else if (charStyle.equals("ElmlBibAccessedDate")) {
								attrAccessedDate = attrTitle;
								accessedDate = elementLabel;
							} else if (charStyle.equals("ElmlBibJournalTitle")) {
								attrContributionTitle = attrTitle;
								contributionTitle = elementLabel;
							} else if (charStyle
									.equals("ElmlBibNewspaperTitle")) {
								attrContributionTitle = attrTitle;
								contributionTitle = elementLabel;
							} else if (charStyle
									.equals("ElmlBibProceedingsTitle")) {
								attrBibTitle = attrTitle;
								title = elementLabel;
							} else if (charStyle.equals("ElmlBibVolumeNr")) {
								attrVolumeNr = attrTitle;
								volumeNr = elementLabel;
							} else if (charStyle
									.equals("ElmlBibProductionPlace")) {
								attrProductionPlace = attrTitle;
								productionPlace = elementLabel;
							} else if (charStyle
									.equals("ElmlBibProductionOrganisation")) {
								attrProductionOrganisation = attrTitle;
								productionOrganisation = elementLabel;
							}
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
		xDialogController.setWindowProperties("Bibliography Entry", 100, 100,
				430, 410);

		/* ---- LABELS ---- */
		Object lbl1 = xDialogController.createLabel("lbl1", "Kurzbezeichnung:",
				10, 13, 50, 14, (short) 0, false);
		xDialogController.addElement("lbl1", lbl1);

		Object lbl2 = xDialogController.createLabel("lbl2", "Typ:", 10, 33, 50,
				14, (short) 0, false);
		xDialogController.addElement("lbl2", lbl2);

		Object lbl3 = xDialogController.createLabel("lbl3", "Autor(en):", 10,
				53, 50, 14, (short) 0, false);
		xDialogController.addElement("lbl3", lbl3);

		Object lbl4 = xDialogController.createLabel("lbl4", "Titel:", 10, 73,
				50, 14, (short) 0, false);
		xDialogController.addElement("lbl4", lbl4);

		Object lbl20 = xDialogController.createLabel("lbl20", "Auszug:", 220,
				73, 50, 14, (short) 0, false);
		xDialogController.addElement("lbl20", lbl20);

		Object lbl5 = xDialogController.createLabel("lbl5", "Jahr:", 10, 93,
				50, 14, (short) 0, false);
		xDialogController.addElement("lbl5", lbl5);

		Object lbl6 = xDialogController.createLabel("lbl6", "Verlag:", 10, 113,
				50, 14, (short) 0, false);
		xDialogController.addElement("lbl6", lbl6);

		Object lbl7 = xDialogController.createLabel("lbl7", "Adresse:", 10,
				133, 50, 14, (short) 0, false);
		xDialogController.addElement("lbl7", lbl7);

		Object lbl8 = xDialogController.createLabel("lbl8", "Ausgabe:", 10,
				153, 50, 14, (short) 0, false);
		xDialogController.addElement("lbl8", lbl8);

		Object lbl9 = xDialogController.createLabel("lbl9", "Seite(n):", 10,
				173, 50, 14, (short) 0, false);
		xDialogController.addElement("lbl9", lbl9);

		Object lbl10 = xDialogController.createLabel("lbl10", "Editor:", 10,
				193, 50, 14, (short) 0, false);
		xDialogController.addElement("lbl10", lbl10);

		Object lbl16 = xDialogController.createLabel("lbl16", "Nummer:", 10,
				213, 50, 14, (short) 0, false);
		xDialogController.addElement("lbl16", lbl16);

		Object lbl11 = xDialogController.createLabel("lbl11", "URL:", 10, 253,
				50, 14, (short) 0, false);
		xDialogController.addElement("lbl11", lbl11);

		Object lbl12 = xDialogController.createLabel("lbl12", "Zugriffsdatum:",
				10, 273, 50, 14, (short) 0, false);
		xDialogController.addElement("lbl12", lbl12);

		Object lbl13 = xDialogController.createLabel("lbl13", "*:", 10, 293,
				50, 14, (short) 0, false);
		xDialogController.addElement("lbl13", lbl13);

		Object lbl14 = xDialogController.createLabel("lbl14", "*:", 10, 313,
				50, 14, (short) 0, false);
		xDialogController.addElement("lbl14", lbl14);

		Object lbl15 = xDialogController.createLabel("lbl15", "*:", 10, 333,
				50, 14, (short) 0, false);
		xDialogController.addElement("lbl15", lbl15);

		Object lbl17 = xDialogController.createLabel("lbl11",
				"Produktionsort:", 220, 253, 50, 14, (short) 0, false);
		xDialogController.addElement("lbl17", lbl17);

		Object lbl18 = xDialogController.createLabel("lbl18", "Organisation:",
				220, 273, 50, 14, (short) 0, false);
		xDialogController.addElement("lbl18", lbl18);

		/* ---- TEXTFIELDS ---- */
		Object txtbibID = xDialogController.createTextField("bibID", bibID, 60,
				10, 50, 14, (short) 1, false, (short) 0);
		xDialogController.addElement("bibID", txtbibID);

		String[] contentTerms = { "Artikel (Zeitschrift)", "Buch",
				"Buchauszug", "Webseite" };

		for (int i = 0; i < contentTerms.length; i++) {
			if (contentTerms[i].equals(type)) {
				itemPos = (short) i;
			}
		}

		Object txttype = xDialogController.createListBox("type", itemPos, 60,
				30, 150, 14, (short) 1, false, (short) 4, contentTerms, true);
		xDialogController.addElement("type", txttype);

		Object txtauthor = xDialogController.createTextField("author", author,
				60, 50, 150, 14, (short) 1, false, (short) 0);
		xDialogController.addElement("author", txtauthor);

		Object txttitle = xDialogController.createTextField("title", title, 60,
				70, 150, 14, (short) 1, false, (short) 0);
		xDialogController.addElement("title", txttitle);

		Object txtcontributionTitle = xDialogController.createTextField(
				"contributionTitle", contributionTitle, 270, 70, 150, 14,
				(short) 1, false, (short) 0);
		xDialogController.addElement("contributionTitle", txtcontributionTitle);

		Object txtyear = xDialogController.createTextField("year", year, 60,
				90, 150, 14, (short) 1, false, (short) 0);
		xDialogController.addElement("year", txtyear);

		Object txtpublisher = xDialogController.createTextField("publisher",
				publisher, 60, 110, 150, 14, (short) 1, false, (short) 0);
		xDialogController.addElement("publisher", txtpublisher);

		Object txtpublicationPlace = xDialogController.createTextField(
				"publicationPlace", publicationPlace, 60, 130, 150, 14,
				(short) 1, false, (short) 0);
		xDialogController.addElement("publicationPlace", txtpublicationPlace);

		Object txtedition = xDialogController.createTextField("edition",
				edition, 60, 150, 150, 14, (short) 1, false, (short) 0);
		xDialogController.addElement("edition", txtedition);

		Object txtpageNr = xDialogController.createTextField("pageNr", pageNr,
				60, 170, 150, 14, (short) 1, false, (short) 0);
		xDialogController.addElement("pageNr", txtpageNr);

		Object txteditor = xDialogController.createTextField("editor", editor,
				60, 190, 150, 14, (short) 1, false, (short) 0);
		xDialogController.addElement("editor", txteditor);

		Object txtvolumeNr = xDialogController.createTextField("volumeNr",
				volumeNr, 60, 210, 150, 14, (short) 1, false, (short) 0);
		xDialogController.addElement("volumeNr", txtvolumeNr);

		Object txturl = xDialogController.createTextField("url", url, 60, 250,
				150, 14, (short) 1, false, (short) 0);
		xDialogController.addElement("url", txturl);

		Object txtaccessedDate = xDialogController.createTextField(
				"accessedDate", accessedDate, 60, 270, 150, 14, (short) 1,
				false, (short) 0);
		xDialogController.addElement("accessedDate", txtaccessedDate);

		Object txtjournalTitle = xDialogController.createTextField(
				"journalTitle", journalTitle, 60, 290, 150, 14, (short) 1,
				false, (short) 0);
		xDialogController.addElement("journalTitle", txtjournalTitle);

		Object txtnewspaperTitle = xDialogController.createTextField(
				"newspaperTitle", newspaperTitle, 60, 310, 150, 14, (short) 1,
				false, (short) 0);
		xDialogController.addElement("newspaperTitle", txtnewspaperTitle);

		Object txtproceedingsTitle = xDialogController.createTextField(
				"proceedingsTitle", proceedingsTitle, 60, 330, 150, 14,
				(short) 1, false, (short) 0);
		xDialogController.addElement("proceedingsTitle", txtproceedingsTitle);

		Object txtproductionPlace = xDialogController.createTextField(
				"productionPlace", productionPlace, 270, 250, 150, 14,
				(short) 1, false, (short) 0);
		xDialogController.addElement("productionPlace", txtproductionPlace);

		Object txtproductionOrganisation = xDialogController.createTextField(
				"productionOrganisation", productionOrganisation, 270, 270,
				150, 14, (short) 1, false, (short) 0);
		xDialogController.addElement("productionOrganisation",
				txtproductionOrganisation);

		/* ---- BUTTONS ---- */
		Object buttonOK = xDialogController.createButton("ok", "OK", 160, 380,
				50, 14, (short) 4);
		xDialogController.addElement("ok", buttonOK);
		xDialogController.attachActionListener("ok");

		Object buttonCancel = xDialogController.createButton("cancel",
				"Abbrechen", 105, 380, 50, 14, (short) 5);
		xDialogController.addElement("cancel", buttonCancel);
		xDialogController.attachActionListener("cancel");

		xDialogController.showDialog();
	}

	public void validateInput() {
		Validator validator = new Validator();

		bibID = xDialogController.getControlText("bibID");
		type = xDialogController.getSelectedText("type");
		author = xDialogController.getControlText("author");
		title = xDialogController.getControlText("title");
		contributionTitle = xDialogController
				.getControlText("contributionTitle");
		year = xDialogController.getControlText("year");
		publisher = xDialogController.getControlText("publisher");
		publicationPlace = xDialogController.getControlText("publicationPlace");
		edition = xDialogController.getControlText("edition");
		pageNr = xDialogController.getControlText("pageNr");
		editor = xDialogController.getControlText("editor");
		volumeNr = xDialogController.getControlText("volumeNr");
		url = xDialogController.getControlText("url");
		accessedDate = xDialogController.getControlText("accessedDate");

		productionPlace = xDialogController.getControlText("productionPlace");
		productionOrganisation = xDialogController
				.getControlText("productionOrganisation");

		if (bibID.equals("")) {
			validator.validateInput("bib_id");
		} else if (type.equals("")) {
			validator.validateInput("bib_type");
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
