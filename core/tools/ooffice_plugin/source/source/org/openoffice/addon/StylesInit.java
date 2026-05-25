package org.openoffice.addon;

import java.awt.Frame;

import com.sun.star.awt.FontSlant;
import com.sun.star.awt.FontWeight;
import com.sun.star.beans.PropertyValue;
import com.sun.star.beans.PropertyVetoException;
import com.sun.star.beans.UnknownPropertyException;
import com.sun.star.beans.XPropertySet;
import com.sun.star.container.ElementExistException;
import com.sun.star.container.NoSuchElementException;
import com.sun.star.container.XIndexReplace;
import com.sun.star.container.XNameAccess;
import com.sun.star.container.XNameContainer;
import com.sun.star.lang.IllegalArgumentException;
import com.sun.star.lang.IndexOutOfBoundsException;
import com.sun.star.lang.WrappedTargetException;
import com.sun.star.lang.XMultiServiceFactory;
import com.sun.star.style.XStyle;
import com.sun.star.style.XStyleFamiliesSupplier;
import com.sun.star.table.BorderLine;
import com.sun.star.text.FontEmphasis;
import com.sun.star.text.FontRelief;
import com.sun.star.text.XChapterNumberingSupplier;
import com.sun.star.text.XTextDocument;
import com.sun.star.uno.Exception;
import com.sun.star.uno.UnoRuntime;

public class StylesInit {

	private XTextDocument TextDocument;

	private XMultiServiceFactory mxDocFactory;

	public StylesInit(XTextDocument TD) {
		TextDocument = TD;

		// Create MultiServiceFactory for TextDocument
		mxDocFactory = (XMultiServiceFactory) UnoRuntime.queryInterface(
				XMultiServiceFactory.class, TextDocument);

		// create all necessary styles and add them to the document
		initLesson();
		initEntry();
		initGoals();
		initUnit();
		initLearningObject();
		initClarify();
		initLook();
		initAct();
		initSummary();
		initUnitSummary();
		initParagraph();
		// initBox();
		initChapterNumbering();
		initGlossary();
		initBibliography();
		initDefinition();
		initBibEntry();
		initBibAttributes();
		initTerm();
		initCitation();
		initCitationRef();
		initBlank();
		initBoxTitle();
	}

	private void initBibEntry() {
		try {
			// Create a new style from the document's factory
			XStyle xStyle = (XStyle) UnoRuntime
					.queryInterface(
							XStyle.class,
							mxDocFactory
									.createInstance("com.sun.star.style.ParagraphStyle"));

			// Access the XPropertySet interface of the new style
			XPropertySet xStyleProps = (XPropertySet) UnoRuntime
					.queryInterface(XPropertySet.class, xStyle);

			// Give the new style a light blue background
			xStyleProps.setPropertyValue("CharFontName", "Arial");
			xStyleProps.setPropertyValue("CharHeight", new Float(12));
			xStyleProps.setPropertyValue("ParaBottomMargin", new Integer(300));

			// Get the StyleFamiliesSupplier interface of the document
			XStyleFamiliesSupplier xSupplier = (XStyleFamiliesSupplier) UnoRuntime
					.queryInterface(XStyleFamiliesSupplier.class, TextDocument);

			// Use the StyleFamiliesSupplier interface to get the XNameAccess
			// interface of the
			// actual style families
			XNameAccess xFamilies = (XNameAccess) UnoRuntime.queryInterface(
					XNameAccess.class, xSupplier.getStyleFamilies());

			// Access the 'ParagraphStyles' Family
			XNameContainer xFamily = (XNameContainer) UnoRuntime
					.queryInterface(XNameContainer.class, xFamilies
							.getByName("ParagraphStyles"));

			// Insert the newly created style into the ParagraphStyles family
			xFamily.insertByName("ElmlBibEntry", xStyle);

		} catch (Exception e) {
			e.printStackTrace(System.out);
		}
	}

	private void initBibAttributes() {
		try {

			String[] bibStyles = { "ElmlBibAuthor", "ElmlBibYear",
					"ElmlBibTitle", "ElmlBibContributionTitle",
					"ElmlBibPublisher", "ElmlBibPublicationPlace",
					"ElmlBibEdition", "ElmlBibPageNr", "ElmlBibEditor",
					"ElmlBibUrl", "ElmlBibAccessedDate", "ElmlBibJournalTitle",
					"ElmlBibNewspaperTitle", "ElmlBibProceedingsTitle",
					"ElmlBibVolumeNr", "ElmlBibProductionPlace",
					"ElmlBibProductionOrganisation" };

			// Get the StyleFamiliesSupplier interface of the document
			XStyleFamiliesSupplier xSupplier = (XStyleFamiliesSupplier) UnoRuntime
					.queryInterface(XStyleFamiliesSupplier.class, TextDocument);

			// Use the StyleFamiliesSupplier interface to get the XNameAccess
			// interface of the
			// actual style families
			XNameAccess xFamilies = (XNameAccess) UnoRuntime.queryInterface(
					XNameAccess.class, xSupplier.getStyleFamilies());

			// Access the 'ParagraphStyles' Family
			XNameContainer xFamily = (XNameContainer) UnoRuntime
					.queryInterface(XNameContainer.class, xFamilies
							.getByName("CharacterStyles"));

			for (int i = 0; i < bibStyles.length; i++) {
				// Create a new style from the document's factory
				XStyle xStyle = (XStyle) UnoRuntime
						.queryInterface(
								XStyle.class,
								mxDocFactory
										.createInstance("com.sun.star.style.CharacterStyle"));

				// Access the XPropertySet interface of the new style
				XPropertySet xStyleProps = (XPropertySet) UnoRuntime
						.queryInterface(XPropertySet.class, xStyle);

				if (bibStyles[i].equals("ElmlBibAuthor")) {
					xStyleProps.setPropertyValue("CharWeight", new Float(
							FontWeight.SEMIBOLD));
				}

				if (bibStyles[i].equals("ElmlBibTitle")) {
					xStyleProps.setPropertyValue("CharPosture",
							FontSlant.ITALIC);
				}

				if (bibStyles[i].equals("ElmlBibVolumeNr")) {
					xStyleProps.setPropertyValue("CharPosture",
							FontSlant.ITALIC);
				}

				// Insert the newly created style into the ParagraphStyles
				// family
				xFamily.insertByName(bibStyles[i], xStyle);

			}

		} catch (Exception e) {
			e.printStackTrace(System.out);
		}
	}

	private void initBoxTitle() {
		try {
			// Create a new style from the document's factory
			XStyle xStyle = (XStyle) UnoRuntime
					.queryInterface(
							XStyle.class,
							mxDocFactory
									.createInstance("com.sun.star.style.CharacterStyle"));

			// Access the XPropertySet interface of the new style
			XPropertySet xStyleProps = (XPropertySet) UnoRuntime
					.queryInterface(XPropertySet.class, xStyle);

			// Give the new style a light blue background
			xStyleProps.setPropertyValue("CharColor", new Integer(0x000000));
			xStyleProps.setPropertyValue("CharWeight", new Float(
					FontWeight.SEMIBOLD));

			// Get the StyleFamiliesSupplier interface of the document
			XStyleFamiliesSupplier xSupplier = (XStyleFamiliesSupplier) UnoRuntime
					.queryInterface(XStyleFamiliesSupplier.class, TextDocument);

			// Use the StyleFamiliesSupplier interface to get the XNameAccess
			// interface of the
			// actual style families
			XNameAccess xFamilies = (XNameAccess) UnoRuntime.queryInterface(
					XNameAccess.class, xSupplier.getStyleFamilies());

			// Access the 'ParagraphStyles' Family
			XNameContainer xFamily = (XNameContainer) UnoRuntime
					.queryInterface(XNameContainer.class, xFamilies
							.getByName("CharacterStyles"));

			// Insert the newly created style into the ParagraphStyles family
			xFamily.insertByName("BoxTitle", xStyle);

		} catch (Exception e) {
			e.printStackTrace(System.out);
		}
	}

	private void initDefinition() {
		try {
			// Create a new style from the document's factory
			XStyle xStyle = (XStyle) UnoRuntime
					.queryInterface(
							XStyle.class,
							mxDocFactory
									.createInstance("com.sun.star.style.ParagraphStyle"));

			// Access the XPropertySet interface of the new style
			XPropertySet xStyleProps = (XPropertySet) UnoRuntime
					.queryInterface(XPropertySet.class, xStyle);

			// Give the new style a light blue background
			xStyleProps.setPropertyValue("CharFontName", "Arial");
			xStyleProps.setPropertyValue("CharHeight", new Float(12));
			xStyleProps.setPropertyValue("ParaBottomMargin", new Integer(300));

			// Get the StyleFamiliesSupplier interface of the document
			XStyleFamiliesSupplier xSupplier = (XStyleFamiliesSupplier) UnoRuntime
					.queryInterface(XStyleFamiliesSupplier.class, TextDocument);

			// Use the StyleFamiliesSupplier interface to get the XNameAccess
			// interface of the
			// actual style families
			XNameAccess xFamilies = (XNameAccess) UnoRuntime.queryInterface(
					XNameAccess.class, xSupplier.getStyleFamilies());

			// Access the 'ParagraphStyles' Family
			XNameContainer xFamily = (XNameContainer) UnoRuntime
					.queryInterface(XNameContainer.class, xFamilies
							.getByName("ParagraphStyles"));

			// Insert the newly created style into the ParagraphStyles family
			xFamily.insertByName("ElmlDefinition", xStyle);

		} catch (Exception e) {
			e.printStackTrace(System.out);
		}
	}

	private void initTerm() {
		try {
			// Create a new style from the document's factory
			XStyle xStyle = (XStyle) UnoRuntime
					.queryInterface(
							XStyle.class,
							mxDocFactory
									.createInstance("com.sun.star.style.CharacterStyle"));

			// Access the XPropertySet interface of the new style
			XPropertySet xStyleProps = (XPropertySet) UnoRuntime
					.queryInterface(XPropertySet.class, xStyle);

			// Give the new style a light blue background
			xStyleProps.setPropertyValue("CharColor", new Integer(0x4ba329));
			xStyleProps.setPropertyValue("CharWeight", new Float(
					FontWeight.SEMIBOLD));

			// Get the StyleFamiliesSupplier interface of the document
			XStyleFamiliesSupplier xSupplier = (XStyleFamiliesSupplier) UnoRuntime
					.queryInterface(XStyleFamiliesSupplier.class, TextDocument);

			// Use the StyleFamiliesSupplier interface to get the XNameAccess
			// interface of the
			// actual style families
			XNameAccess xFamilies = (XNameAccess) UnoRuntime.queryInterface(
					XNameAccess.class, xSupplier.getStyleFamilies());

			// Access the 'ParagraphStyles' Family
			XNameContainer xFamily = (XNameContainer) UnoRuntime
					.queryInterface(XNameContainer.class, xFamilies
							.getByName("CharacterStyles"));

			// Insert the newly created style into the ParagraphStyles family
			xFamily.insertByName("ElmlTerm", xStyle);

		} catch (Exception e) {
			e.printStackTrace(System.out);
		}
	}

	private void initCitation() {
		try {
			// Create a new style from the document's factory
			XStyle xStyle = (XStyle) UnoRuntime
					.queryInterface(
							XStyle.class,
							mxDocFactory
									.createInstance("com.sun.star.style.CharacterStyle"));

			// Access the XPropertySet interface of the new style
			XPropertySet xStyleProps = (XPropertySet) UnoRuntime
					.queryInterface(XPropertySet.class, xStyle);

			// Give the new style a light blue background
			xStyleProps.setPropertyValue("CharWeight", new Float(
					FontWeight.SEMIBOLD));
			xStyleProps.setPropertyValue("CharPosture", FontSlant.ITALIC);

			// Get the StyleFamiliesSupplier interface of the document
			XStyleFamiliesSupplier xSupplier = (XStyleFamiliesSupplier) UnoRuntime
					.queryInterface(XStyleFamiliesSupplier.class, TextDocument);

			// Use the StyleFamiliesSupplier interface to get the XNameAccess
			// interface of the
			// actual style families
			XNameAccess xFamilies = (XNameAccess) UnoRuntime.queryInterface(
					XNameAccess.class, xSupplier.getStyleFamilies());

			// Access the 'ParagraphStyles' Family
			XNameContainer xFamily = (XNameContainer) UnoRuntime
					.queryInterface(XNameContainer.class, xFamilies
							.getByName("CharacterStyles"));

			// Insert the newly created style into the ParagraphStyles family
			xFamily.insertByName("ElmlCitation", xStyle);

		} catch (Exception e) {
			e.printStackTrace(System.out);
		}
	}

	private void initCitationRef() {
		try {
			// Create a new style from the document's factory
			XStyle xStyle = (XStyle) UnoRuntime
					.queryInterface(
							XStyle.class,
							mxDocFactory
									.createInstance("com.sun.star.style.CharacterStyle"));

			// Access the XPropertySet interface of the new style
			XPropertySet xStyleProps = (XPropertySet) UnoRuntime
					.queryInterface(XPropertySet.class, xStyle);

			// Give the new style a light blue background
			xStyleProps.setPropertyValue("CharWeight", new Float(
					FontWeight.SEMIBOLD));

			// Get the StyleFamiliesSupplier interface of the document
			XStyleFamiliesSupplier xSupplier = (XStyleFamiliesSupplier) UnoRuntime
					.queryInterface(XStyleFamiliesSupplier.class, TextDocument);

			// Use the StyleFamiliesSupplier interface to get the XNameAccess
			// interface of the
			// actual style families
			XNameAccess xFamilies = (XNameAccess) UnoRuntime.queryInterface(
					XNameAccess.class, xSupplier.getStyleFamilies());

			// Access the 'ParagraphStyles' Family
			XNameContainer xFamily = (XNameContainer) UnoRuntime
					.queryInterface(XNameContainer.class, xFamilies
							.getByName("CharacterStyles"));

			// Insert the newly created style into the ParagraphStyles family
			xFamily.insertByName("ElmlCitationRef", xStyle);

		} catch (Exception e) {
			e.printStackTrace(System.out);
		}
	}

	private void initBlank() {
		try {
			// Create a new style from the document's factory
			XStyle xStyle = (XStyle) UnoRuntime
					.queryInterface(
							XStyle.class,
							mxDocFactory
									.createInstance("com.sun.star.style.CharacterStyle"));

			// Access the XPropertySet interface of the new style
			XPropertySet xStyleProps = (XPropertySet) UnoRuntime
					.queryInterface(XPropertySet.class, xStyle);

			// Give the new style a light blue background
			xStyleProps.setPropertyValue("CharHeight", new Float(10));
			xStyleProps.setPropertyValue("CharColor", new Integer(0x949494));	
			xStyleProps.setPropertyValue("CharShadowed", Boolean.TRUE);	
			
			// Get the StyleFamiliesSupplier interface of the document
			XStyleFamiliesSupplier xSupplier = (XStyleFamiliesSupplier) UnoRuntime
					.queryInterface(XStyleFamiliesSupplier.class, TextDocument);

			// Use the StyleFamiliesSupplier interface to get the XNameAccess
			// interface of the
			// actual style families
			XNameAccess xFamilies = (XNameAccess) UnoRuntime.queryInterface(
					XNameAccess.class, xSupplier.getStyleFamilies());


			// Access the 'ParagraphStyles' Family
			XNameContainer xFamily = (XNameContainer) UnoRuntime
					.queryInterface(XNameContainer.class, xFamilies
							.getByName("CharacterStyles"));

			// Insert the newly created style into the ParagraphStyles family
			xFamily.insertByName("ElmlBlank", xStyle);

		} catch (Exception e) {
			e.printStackTrace(System.out);
		}
	}

	private void initGlossary() {
		try {
			// Create a new style from the document's factory
			XStyle xStyle = (XStyle) UnoRuntime
					.queryInterface(
							XStyle.class,
							mxDocFactory
									.createInstance("com.sun.star.style.ParagraphStyle"));

			// Access the XPropertySet interface of the new style
			XPropertySet xStyleProps = (XPropertySet) UnoRuntime
					.queryInterface(XPropertySet.class, xStyle);

			// Give the new style a light blue background
			xStyleProps
					.setPropertyValue("ParaBackColor", new Integer(0xc0ecb9));
			xStyleProps.setPropertyValue("CharFontName", "Arial");
			xStyleProps.setPropertyValue("CharHeight", new Float(20));
			xStyleProps.setPropertyValue("ParaBottomMargin", new Integer(400));

			// Get the StyleFamiliesSupplier interface of the document
			XStyleFamiliesSupplier xSupplier = (XStyleFamiliesSupplier) UnoRuntime
					.queryInterface(XStyleFamiliesSupplier.class, TextDocument);

			// Use the StyleFamiliesSupplier interface to get the XNameAccess
			// interface of the
			// actual style families
			XNameAccess xFamilies = (XNameAccess) UnoRuntime.queryInterface(
					XNameAccess.class, xSupplier.getStyleFamilies());

			// Access the 'ParagraphStyles' Family
			XNameContainer xFamily = (XNameContainer) UnoRuntime
					.queryInterface(XNameContainer.class, xFamilies
							.getByName("ParagraphStyles"));

			// Insert the newly created style into the ParagraphStyles family
			xFamily.insertByName("ElmlGlossary", xStyle);

		} catch (Exception e) {
			e.printStackTrace(System.out);
		}
	}

	private void initBibliography() {
		try {
			// Create a new style from the document's factory
			XStyle xStyle = (XStyle) UnoRuntime
					.queryInterface(
							XStyle.class,
							mxDocFactory
									.createInstance("com.sun.star.style.ParagraphStyle"));

			// Access the XPropertySet interface of the new style
			XPropertySet xStyleProps = (XPropertySet) UnoRuntime
					.queryInterface(XPropertySet.class, xStyle);

			// Give the new style a light blue background
			xStyleProps
					.setPropertyValue("ParaBackColor", new Integer(0xc0ecb9));
			xStyleProps.setPropertyValue("CharFontName", "Arial");
			xStyleProps.setPropertyValue("CharHeight", new Float(20));
			xStyleProps.setPropertyValue("ParaBottomMargin", new Integer(400));

			// Get the StyleFamiliesSupplier interface of the document
			XStyleFamiliesSupplier xSupplier = (XStyleFamiliesSupplier) UnoRuntime
					.queryInterface(XStyleFamiliesSupplier.class, TextDocument);

			// Use the StyleFamiliesSupplier interface to get the XNameAccess
			// interface of the
			// actual style families
			XNameAccess xFamilies = (XNameAccess) UnoRuntime.queryInterface(
					XNameAccess.class, xSupplier.getStyleFamilies());

			// Access the 'ParagraphStyles' Family
			XNameContainer xFamily = (XNameContainer) UnoRuntime
					.queryInterface(XNameContainer.class, xFamilies
							.getByName("ParagraphStyles"));

			// Insert the newly created style into the ParagraphStyles family
			xFamily.insertByName("ElmlBibliography", xStyle);

		} catch (Exception e) {
			e.printStackTrace(System.out);
		}
	}

	private void initChapterNumbering() {
		setChapterStyle("ElmlLesson", 0);
		setChapterStyle("ElmlUnit", 1);
		setChapterStyle("ElmlLearningObject", 2);
		setChapterStyle("ElmlClarify", 3);
		setChapterStyle("ElmlLook", 4);
		setChapterStyle("ElmlAct", 5);
	}

	/**
	 * Assign a new style to a chapter numbering level
	 * 
	 * @param chapterStyle
	 *            the paragraph stlye which should use chapter numbering
	 * @param level
	 *            the numbering level that should be updated with a new style
	 */
	private void setChapterStyle(String chapterStyle, int level) {
		XChapterNumberingSupplier xChapterSupplier = (XChapterNumberingSupplier) UnoRuntime
				.queryInterface(XChapterNumberingSupplier.class, TextDocument);

		XIndexReplace xChapters = xChapterSupplier.getChapterNumberingRules();
		PropertyValue[] aProps = null;

		try {
			aProps = (PropertyValue[]) xChapters.getByIndex(level);
		} catch (IndexOutOfBoundsException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		} catch (WrappedTargetException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		for (int j = 0; j < aProps.length; j++) {
			if (aProps[j].Name.equals("HeadingStyleName")) {
				aProps[j].Value = chapterStyle;
			} else if (aProps[j].Name.equals("NumberingType")) {
				// TODO: Disabled Chapter Numbering, since entry, goals and so
				// on don't count
				// aProps[j].Value = NumberingType.ARABIC;
			} else if (aProps[j].Name.equals("ParentNumbering")) {
				aProps[j].Value = new Short((short) (level + 2));
			}
		}
		try {
			xChapters.replaceByIndex(level, aProps);
		} catch (IllegalArgumentException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IndexOutOfBoundsException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (WrappedTargetException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	private void initClarify() {
		try {
			// Create a new style from the document's factory
			XStyle xStyle = (XStyle) UnoRuntime
					.queryInterface(
							XStyle.class,
							mxDocFactory
									.createInstance("com.sun.star.style.ParagraphStyle"));

			// Access the XPropertySet interface of the new style
			XPropertySet xStyleProps = (XPropertySet) UnoRuntime
					.queryInterface(XPropertySet.class, xStyle);

			// Give the new style a background
			xStyleProps
					.setPropertyValue("ParaBackColor", new Integer(0xfec3ab));
			xStyleProps.setPropertyValue("CharFontName", "Arial");
			xStyleProps.setPropertyValue("CharHeight", new Float(13));
			xStyleProps.setPropertyValue("ParaBottomMargin", new Integer(400));
			xStyleProps.setPropertyValue("ParaTopMargin", new Integer(400));

			// Get the StyleFamiliesSupplier interface of the document
			XStyleFamiliesSupplier xSupplier = (XStyleFamiliesSupplier) UnoRuntime
					.queryInterface(XStyleFamiliesSupplier.class, TextDocument);

			// Use the StyleFamiliesSupplier interface to get the XNameAccess
			// interface of the
			// actual style families
			XNameAccess xFamilies = (XNameAccess) UnoRuntime.queryInterface(
					XNameAccess.class, xSupplier.getStyleFamilies());

			// Access the 'ParagraphStyles' Family
			XNameContainer xFamily = (XNameContainer) UnoRuntime
					.queryInterface(XNameContainer.class, xFamilies
							.getByName("ParagraphStyles"));

			// Insert the newly created style into the ParagraphStyles family
			xFamily.insertByName("ElmlClarify", xStyle);

		} catch (Exception e) {
			e.printStackTrace(System.out);
		}
	}

	private void initLook() {
		try {
			// Create a new style from the document's factory
			XStyle xStyle = (XStyle) UnoRuntime
					.queryInterface(
							XStyle.class,
							mxDocFactory
									.createInstance("com.sun.star.style.ParagraphStyle"));

			// Access the XPropertySet interface of the new style
			XPropertySet xStyleProps = (XPropertySet) UnoRuntime
					.queryInterface(XPropertySet.class, xStyle);

			// Give the new style a background
			xStyleProps
					.setPropertyValue("ParaBackColor", new Integer(0xfec3ab));
			xStyleProps.setPropertyValue("CharFontName", "Arial");
			xStyleProps.setPropertyValue("CharHeight", new Float(13));
			xStyleProps.setPropertyValue("ParaBottomMargin", new Integer(400));
			xStyleProps.setPropertyValue("ParaTopMargin", new Integer(400));

			// Get the StyleFamiliesSupplier interface of the document
			XStyleFamiliesSupplier xSupplier = (XStyleFamiliesSupplier) UnoRuntime
					.queryInterface(XStyleFamiliesSupplier.class, TextDocument);

			// Use the StyleFamiliesSupplier interface to get the XNameAccess
			// interface of the
			// actual style families
			XNameAccess xFamilies = (XNameAccess) UnoRuntime.queryInterface(
					XNameAccess.class, xSupplier.getStyleFamilies());

			// Access the 'ParagraphStyles' Family
			XNameContainer xFamily = (XNameContainer) UnoRuntime
					.queryInterface(XNameContainer.class, xFamilies
							.getByName("ParagraphStyles"));

			// Insert the newly created style into the ParagraphStyles family
			xFamily.insertByName("ElmlLook", xStyle);

		} catch (Exception e) {
			e.printStackTrace(System.out);
		}
	}

	private void initAct() {
		try {
			// Create a new style from the document's factory
			XStyle xStyle = (XStyle) UnoRuntime
					.queryInterface(
							XStyle.class,
							mxDocFactory
									.createInstance("com.sun.star.style.ParagraphStyle"));

			// Access the XPropertySet interface of the new style
			XPropertySet xStyleProps = (XPropertySet) UnoRuntime
					.queryInterface(XPropertySet.class, xStyle);

			// Give the new style a background
			xStyleProps
					.setPropertyValue("ParaBackColor", new Integer(0xfec3ab));
			xStyleProps.setPropertyValue("CharFontName", "Arial");
			xStyleProps.setPropertyValue("CharHeight", new Float(13));
			xStyleProps.setPropertyValue("ParaBottomMargin", new Integer(400));
			xStyleProps.setPropertyValue("ParaTopMargin", new Integer(400));

			// Get the StyleFamiliesSupplier interface of the document
			XStyleFamiliesSupplier xSupplier = (XStyleFamiliesSupplier) UnoRuntime
					.queryInterface(XStyleFamiliesSupplier.class, TextDocument);

			// Use the StyleFamiliesSupplier interface to get the XNameAccess
			// interface of the
			// actual style families
			XNameAccess xFamilies = (XNameAccess) UnoRuntime.queryInterface(
					XNameAccess.class, xSupplier.getStyleFamilies());

			// Access the 'ParagraphStyles' Family
			XNameContainer xFamily = (XNameContainer) UnoRuntime
					.queryInterface(XNameContainer.class, xFamilies
							.getByName("ParagraphStyles"));

			// Insert the newly created style into the ParagraphStyles family
			xFamily.insertByName("ElmlAct", xStyle);

		} catch (Exception e) {
			e.printStackTrace(System.out);
		}
	}

	private void initLearningObject() {
		try {
			// Create a new style from the document's factory
			XStyle xStyle = (XStyle) UnoRuntime
					.queryInterface(
							XStyle.class,
							mxDocFactory
									.createInstance("com.sun.star.style.ParagraphStyle"));

			// Access the XPropertySet interface of the new style
			XPropertySet xStyleProps = (XPropertySet) UnoRuntime
					.queryInterface(XPropertySet.class, xStyle);

			// Give the new style a background
			xStyleProps
					.setPropertyValue("ParaBackColor", new Integer(0xfda09a));
			xStyleProps.setPropertyValue("CharFontName", "Arial");
			xStyleProps.setPropertyValue("CharHeight", new Float(15));
			xStyleProps.setPropertyValue("ParaBottomMargin", new Integer(200));
			xStyleProps.setPropertyValue("ParaTopMargin", new Integer(400));

			// Get the StyleFamiliesSupplier interface of the document
			XStyleFamiliesSupplier xSupplier = (XStyleFamiliesSupplier) UnoRuntime
					.queryInterface(XStyleFamiliesSupplier.class, TextDocument);

			// Use the StyleFamiliesSupplier interface to get the XNameAccess
			// interface of the
			// actual style families
			XNameAccess xFamilies = (XNameAccess) UnoRuntime.queryInterface(
					XNameAccess.class, xSupplier.getStyleFamilies());

			// Access the 'ParagraphStyles' Family
			XNameContainer xFamily = (XNameContainer) UnoRuntime
					.queryInterface(XNameContainer.class, xFamilies
							.getByName("ParagraphStyles"));

			// Insert the newly created style into the ParagraphStyles family
			xFamily.insertByName("ElmlLearningObject", xStyle);

		} catch (Exception e) {
			e.printStackTrace(System.out);
		}
	}

	private void initParagraph() {
		try {
			// Create a new style from the document's factory
			XStyle xStyle = (XStyle) UnoRuntime
					.queryInterface(
							XStyle.class,
							mxDocFactory
									.createInstance("com.sun.star.style.ParagraphStyle"));

			// Access the XPropertySet interface of the new style
			XPropertySet xStyleProps = (XPropertySet) UnoRuntime
					.queryInterface(XPropertySet.class, xStyle);

			// Give the new style background
			xStyleProps.setPropertyValue("CharFontName", "Arial");
			xStyleProps.setPropertyValue("CharHeight", new Float(12));
			xStyleProps.setPropertyValue("ParaBottomMargin", new Integer(300));

			// Get the StyleFamiliesSupplier interface of the document
			XStyleFamiliesSupplier xSupplier = (XStyleFamiliesSupplier) UnoRuntime
					.queryInterface(XStyleFamiliesSupplier.class, TextDocument);

			// Use the StyleFamiliesSupplier interface to get the XNameAccess
			// interface of the
			// actual style families
			XNameAccess xFamilies = (XNameAccess) UnoRuntime.queryInterface(
					XNameAccess.class, xSupplier.getStyleFamilies());

			// Access the 'ParagraphStyles' Family
			XNameContainer xFamily = (XNameContainer) UnoRuntime
					.queryInterface(XNameContainer.class, xFamilies
							.getByName("ParagraphStyles"));

			// Insert the newly created style into the ParagraphStyles family
			xFamily.insertByName("ElmlParagraph", xStyle);

		} catch (Exception e) {
			e.printStackTrace(System.out);
		}
	}

	private void initBox() {
		try {
			// Create a new style from the document's factory
			XStyle xStyle = (XStyle) UnoRuntime
					.queryInterface(
							XStyle.class,
							mxDocFactory
									.createInstance("com.sun.star.style.ParagraphStyle"));

			// Access the XPropertySet interface of the new style
			XPropertySet xStyleProps = (XPropertySet) UnoRuntime
					.queryInterface(XPropertySet.class, xStyle);

			BorderLine border = new BorderLine();
			// border.Color = new Integer(0x515461);
			border.InnerLineWidth = border.LineDistance = 0;
			border.OuterLineWidth = (short) 20;

			// Give the new style background
			xStyleProps.setPropertyValue("CharFontName", "Arial");
			xStyleProps.setPropertyValue("CharHeight", new Float(12));
			xStyleProps.setPropertyValue("ParaBottomMargin", new Integer(300));

			xStyleProps.setPropertyValue("LeftBorder", border);
			xStyleProps.setPropertyValue("RightBorder", border);
			xStyleProps.setPropertyValue("TopBorder", border);
			xStyleProps.setPropertyValue("BottomBorder", border);
			xStyleProps.setPropertyValue("BorderDistance", new Integer(200));
			xStyleProps.setPropertyValue("ParaIsConnectBorder", Boolean.FALSE);

			// Get the StyleFamiliesSupplier interface of the document
			XStyleFamiliesSupplier xSupplier = (XStyleFamiliesSupplier) UnoRuntime
					.queryInterface(XStyleFamiliesSupplier.class, TextDocument);

			// Use the StyleFamiliesSupplier interface to get the XNameAccess
			// interface of the
			// actual style families
			XNameAccess xFamilies = (XNameAccess) UnoRuntime.queryInterface(
					XNameAccess.class, xSupplier.getStyleFamilies());

			// Access the 'ParagraphStyles' Family
			XNameContainer xFamily = (XNameContainer) UnoRuntime
					.queryInterface(XNameContainer.class, xFamilies
							.getByName("ParagraphStyles"));

			// Insert the newly created style into the ParagraphStyles family
			xFamily.insertByName("ElmlBox", xStyle);

		} catch (Exception e) {
			e.printStackTrace(System.out);
		}
	}

	public void initLesson() {

		// Create a new style from the document's factory
		XStyle xStyle = null;
		try {
			xStyle = (XStyle) UnoRuntime
					.queryInterface(
							XStyle.class,
							mxDocFactory
									.createInstance("com.sun.star.style.ParagraphStyle"));
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		// Access the XPropertySet interface of the new style
		XPropertySet xStyleProps = (XPropertySet) UnoRuntime.queryInterface(
				XPropertySet.class, xStyle);

		// Give the new style a light blue background
		try {
			xStyleProps
					.setPropertyValue("ParaBackColor", new Integer(0xdedeff));
			xStyleProps.setPropertyValue("CharFontName", "Arial");
			xStyleProps.setPropertyValue("CharHeight", new Float(20));
			xStyleProps.setPropertyValue("ParaBottomMargin", new Integer(400));
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

		// Get the StyleFamiliesSupplier interface of the document
		XStyleFamiliesSupplier xSupplier = (XStyleFamiliesSupplier) UnoRuntime
				.queryInterface(XStyleFamiliesSupplier.class, TextDocument);

		// Use the StyleFamiliesSupplier interface to get the XNameAccess
		// interface of the
		// actual style families
		XNameAccess xFamilies = (XNameAccess) UnoRuntime.queryInterface(
				XNameAccess.class, xSupplier.getStyleFamilies());

		// Access the 'ParagraphStyles' Family
		XNameContainer xFamily = null;
		try {
			xFamily = (XNameContainer) UnoRuntime.queryInterface(
					XNameContainer.class, xFamilies.getByName("ParagraphStyles"));
		} catch (NoSuchElementException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (WrappedTargetException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		// Insert the newly created style into the ParagraphStyles family
		try {
			xFamily.insertByName("ElmlLesson", xStyle);
		} catch (IllegalArgumentException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ElementExistException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (WrappedTargetException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

	private void initEntry() {
		try {
			// Create a new style from the document's factory
			XStyle xStyle = (XStyle) UnoRuntime
					.queryInterface(
							XStyle.class,
							mxDocFactory
									.createInstance("com.sun.star.style.ParagraphStyle"));

			// Access the XPropertySet interface of the new style
			XPropertySet xStyleProps = (XPropertySet) UnoRuntime
					.queryInterface(XPropertySet.class, xStyle);

			// Give the new style a background
			xStyleProps
					.setPropertyValue("ParaBackColor", new Integer(0xfff3c1));
			xStyleProps.setPropertyValue("CharFontName", "Arial");
			xStyleProps.setPropertyValue("CharHeight", new Float(14));
			xStyleProps.setPropertyValue("ParaBottomMargin", new Integer(400));

			// Get the StyleFamiliesSupplier interface of the document
			XStyleFamiliesSupplier xSupplier = (XStyleFamiliesSupplier) UnoRuntime
					.queryInterface(XStyleFamiliesSupplier.class, TextDocument);

			// Use the StyleFamiliesSupplier interface to get the XNameAccess
			// interface of the
			// actual style families
			XNameAccess xFamilies = (XNameAccess) UnoRuntime.queryInterface(
					XNameAccess.class, xSupplier.getStyleFamilies());

			// Access the 'ParagraphStyles' Family
			XNameContainer xFamily = (XNameContainer) UnoRuntime
					.queryInterface(XNameContainer.class, xFamilies
							.getByName("ParagraphStyles"));

			// Insert the newly created style into the ParagraphStyles family
			xFamily.insertByName("ElmlEntry", xStyle);

		} catch (Exception e) {
			e.printStackTrace(System.out);
		}
	}

	private void initGoals() {
		try {
			// Create a new style from the document's factory
			XStyle xStyle = (XStyle) UnoRuntime
					.queryInterface(
							XStyle.class,
							mxDocFactory
									.createInstance("com.sun.star.style.ParagraphStyle"));

			// Access the XPropertySet interface of the new style
			XPropertySet xStyleProps = (XPropertySet) UnoRuntime
					.queryInterface(XPropertySet.class, xStyle);

			// Give the new style a background
			xStyleProps
					.setPropertyValue("ParaBackColor", new Integer(0xfff3c1));
			xStyleProps.setPropertyValue("CharFontName", "Arial");
			xStyleProps.setPropertyValue("CharHeight", new Float(14));
			xStyleProps.setPropertyValue("ParaTopMargin", new Integer(400));
			xStyleProps.setPropertyValue("ParaBottomMargin", new Integer(400));

			// Get the StyleFamiliesSupplier interface of the document
			XStyleFamiliesSupplier xSupplier = (XStyleFamiliesSupplier) UnoRuntime
					.queryInterface(XStyleFamiliesSupplier.class, TextDocument);

			// Use the StyleFamiliesSupplier interface to get the XNameAccess
			// interface of the
			// actual style families
			XNameAccess xFamilies = (XNameAccess) UnoRuntime.queryInterface(
					XNameAccess.class, xSupplier.getStyleFamilies());

			// Access the 'ParagraphStyles' Family
			XNameContainer xFamily = (XNameContainer) UnoRuntime
					.queryInterface(XNameContainer.class, xFamilies
							.getByName("ParagraphStyles"));

			// Insert the newly created style into the ParagraphStyles family
			xFamily.insertByName("ElmlGoals", xStyle);

		} catch (Exception e) {
			e.printStackTrace(System.out);
		}
	}

	public void initUnit() {
		try {
			// Create a new style from the document's factory
			XStyle xStyle = (XStyle) UnoRuntime
					.queryInterface(
							XStyle.class,
							mxDocFactory
									.createInstance("com.sun.star.style.ParagraphStyle"));

			// Access the XPropertySet interface of the new style
			XPropertySet xStyleProps = (XPropertySet) UnoRuntime
					.queryInterface(XPropertySet.class, xStyle);

			// Give the new style a light blue background
			xStyleProps
					.setPropertyValue("ParaBackColor", new Integer(0xc0ecb9));
			xStyleProps.setPropertyValue("CharFontName", "Arial");
			xStyleProps.setPropertyValue("CharHeight", new Float(17));
			xStyleProps.setPropertyValue("ParaTopMargin", new Integer(600));
			xStyleProps.setPropertyValue("ParaBottomMargin", new Integer(400));

			// Get the StyleFamiliesSupplier interface of the document
			XStyleFamiliesSupplier xSupplier = (XStyleFamiliesSupplier) UnoRuntime
					.queryInterface(XStyleFamiliesSupplier.class, TextDocument);

			// Use the StyleFamiliesSupplier interface to get the XNameAccess
			// interface of the
			// actual style families
			XNameAccess xFamilies = (XNameAccess) UnoRuntime.queryInterface(
					XNameAccess.class, xSupplier.getStyleFamilies());

			// Access the 'ParagraphStyles' Family
			XNameContainer xFamily = (XNameContainer) UnoRuntime
					.queryInterface(XNameContainer.class, xFamilies
							.getByName("ParagraphStyles"));

			// Insert the newly created style into the ParagraphStyles family
			xFamily.insertByName("ElmlUnit", xStyle);

		} catch (Exception e) {
			e.printStackTrace(System.out);
		}
	}

	public void initSummary() {
		try {
			// Create a new style from the document's factory
			XStyle xStyle = (XStyle) UnoRuntime
					.queryInterface(
							XStyle.class,
							mxDocFactory
									.createInstance("com.sun.star.style.ParagraphStyle"));

			// Access the XPropertySet interface of the new style
			XPropertySet xStyleProps = (XPropertySet) UnoRuntime
					.queryInterface(XPropertySet.class, xStyle);

			// Give the new style a light blue background
			xStyleProps
					.setPropertyValue("ParaBackColor", new Integer(0xb2e6aa));
			xStyleProps.setPropertyValue("CharFontName", "Arial");
			xStyleProps.setPropertyValue("CharHeight", new Float(20));
			xStyleProps.setPropertyValue("ParaTopMargin", new Integer(600));
			xStyleProps.setPropertyValue("ParaBottomMargin", new Integer(400));

			// Get the StyleFamiliesSupplier interface of the document
			XStyleFamiliesSupplier xSupplier = (XStyleFamiliesSupplier) UnoRuntime
					.queryInterface(XStyleFamiliesSupplier.class, TextDocument);

			// Use the StyleFamiliesSupplier interface to get the XNameAccess
			// interface of the
			// actual style families
			XNameAccess xFamilies = (XNameAccess) UnoRuntime.queryInterface(
					XNameAccess.class, xSupplier.getStyleFamilies());

			// Access the 'ParagraphStyles' Family
			XNameContainer xFamily = (XNameContainer) UnoRuntime
					.queryInterface(XNameContainer.class, xFamilies
							.getByName("ParagraphStyles"));

			// Insert the newly created style into the ParagraphStyles family
			xFamily.insertByName("ElmlSummary", xStyle);

		} catch (Exception e) {
			e.printStackTrace(System.out);
		}
	}

	private void initUnitSummary() {
		try {
			// Create a new style from the document's factory
			XStyle xStyle = (XStyle) UnoRuntime
					.queryInterface(
							XStyle.class,
							mxDocFactory
									.createInstance("com.sun.star.style.ParagraphStyle"));

			// Access the XPropertySet interface of the new style
			XPropertySet xStyleProps = (XPropertySet) UnoRuntime
					.queryInterface(XPropertySet.class, xStyle);

			// Give the new style a background
			xStyleProps
					.setPropertyValue("ParaBackColor", new Integer(0xffb99d));
			xStyleProps.setPropertyValue("CharFontName", "Arial");
			xStyleProps.setPropertyValue("CharHeight", new Float(15));
			xStyleProps.setPropertyValue("ParaBottomMargin", new Integer(200));
			xStyleProps.setPropertyValue("ParaTopMargin", new Integer(400));

			// Get the StyleFamiliesSupplier interface of the document
			XStyleFamiliesSupplier xSupplier = (XStyleFamiliesSupplier) UnoRuntime
					.queryInterface(XStyleFamiliesSupplier.class, TextDocument);

			// Use the StyleFamiliesSupplier interface to get the XNameAccess
			// interface of the
			// actual style families
			XNameAccess xFamilies = (XNameAccess) UnoRuntime.queryInterface(
					XNameAccess.class, xSupplier.getStyleFamilies());

			// Access the 'ParagraphStyles' Family
			XNameContainer xFamily = (XNameContainer) UnoRuntime
					.queryInterface(XNameContainer.class, xFamilies
							.getByName("ParagraphStyles"));

			// Insert the newly created style into the ParagraphStyles family
			xFamily.insertByName("ElmlUnitSummary", xStyle);

		} catch (Exception e) {
			e.printStackTrace(System.out);
		}
	}

}
