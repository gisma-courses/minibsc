/*
 * ContentRemove.java
 * 
 * Helper class to delete elements including its content
 * 
 * @author      André Locher
 * @version     1.0
 * @since       1.0
 * 
 */

package org.openoffice.addon;

import java.awt.Frame;
import java.awt.HeadlessException;
import java.util.HashMap;
import java.util.Map;

import com.sun.star.beans.PropertyVetoException;
import com.sun.star.beans.UnknownPropertyException;
import com.sun.star.beans.XPropertySet;
import com.sun.star.container.NoSuchElementException;
import com.sun.star.container.XContentEnumerationAccess;
import com.sun.star.container.XEnumeration;
import com.sun.star.container.XEnumerationAccess;
import com.sun.star.container.XIndexAccess;
import com.sun.star.container.XNamed;
import com.sun.star.frame.XController;
import com.sun.star.frame.XModel;
import com.sun.star.lang.IllegalArgumentException;
import com.sun.star.lang.IndexOutOfBoundsException;
import com.sun.star.lang.WrappedTargetException;
import com.sun.star.lang.XComponent;
import com.sun.star.lang.XMultiServiceFactory;
import com.sun.star.lang.XServiceInfo;
import com.sun.star.style.BreakType;
import com.sun.star.text.XDependentTextField;
import com.sun.star.text.XParagraphCursor;
import com.sun.star.text.XRelativeTextContentInsert;
import com.sun.star.text.XText;
import com.sun.star.text.XTextContent;
import com.sun.star.text.XTextDocument;
import com.sun.star.text.XTextRange;
import com.sun.star.text.XTextSection;
import com.sun.star.text.XTextViewCursor;
import com.sun.star.text.XTextViewCursorSupplier;
import com.sun.star.uno.Exception;
import com.sun.star.uno.UnoRuntime;
import com.sun.star.util.XRefreshable;

public class ContentRemove {
	static String ELML_LESSON = "ElmlLesson";

	static String ELML_UNIT = "ElmlUnit";

	static String ELML_ENTRY = "ElmlEntry";

	static String ELML_GOALS = "ElmlGoals";

	static String ELML_LEARNINGOBJECT = "ElmlLearningObject";

	static String ELML_CLARIFY = "ElmlClarify";

	static String ELML_LOOK = "ElmlLook";

	static String ELML_ACT = "ElmlAct";

	static String ELML_SUMMARY = "ElmlSummary";

	static String ELML_UNITSUMMARY = "ElmlUnitSummary";

	static String ELML_SELFASSESSMENT = "ElmlSelfAssessment";

	static String ELML_FURTHERREADING = "ElmlFurtherReading";

	static String ELML_GLOSSARY = "ElmlGlossary";

	static String ELML_BIBLIOGRAPHY = "ElmlBibliography";

	static String ELML_METADATA = "ElmlMetadata";

	static String ELML_DEFINITION = "ElmlDefinition";

	static String ELML_BIBENTRY = "ElmlBibEntry";

	private String[] ElmlLesson = { ELML_LESSON };

	private String[] ElmlDefinition = { ELML_DEFINITION, ELML_BIBLIOGRAPHY };

	private String[] ElmlBibEntry = { ELML_BIBENTRY, ELML_BIBLIOGRAPHY };

	private String[] ElmlUnit = { ELML_UNIT, ELML_GLOSSARY, ELML_BIBLIOGRAPHY,
			ELML_METADATA, ELML_SUMMARY };

	private String[] ElmlSummary = { ELML_SUMMARY, ELML_GLOSSARY, ELML_UNIT,
			ELML_BIBLIOGRAPHY, ELML_METADATA };

	private String[] ElmlUnitSummary = { ELML_UNITSUMMARY, ELML_GLOSSARY,
			ELML_UNIT, ELML_BIBLIOGRAPHY, ELML_METADATA, ELML_SELFASSESSMENT,
			ELML_FURTHERREADING, ELML_LEARNINGOBJECT };

	private String[] ElmlEntry = { ELML_ENTRY, ELML_UNIT, ELML_GOALS,
			ELML_LEARNINGOBJECT, ELML_GLOSSARY, ELML_BIBLIOGRAPHY };

	private String[] ElmlGoals = { ELML_GOALS, ELML_LEARNINGOBJECT, ELML_UNIT,
			ELML_GLOSSARY, ELML_BIBLIOGRAPHY };

	private String[] ElmlLearningObject = { ELML_LEARNINGOBJECT, ELML_SUMMARY,
			ELML_SELFASSESSMENT, ELML_FURTHERREADING, ELML_UNIT, ELML_GLOSSARY,
			ELML_BIBLIOGRAPHY };

	private String[] ElmlClarify = { ELML_CLARIFY, ELML_LOOK, ELML_ACT,
			ELML_LEARNINGOBJECT, ELML_SUMMARY, ELML_SELFASSESSMENT,
			ELML_FURTHERREADING, ELML_UNIT, ELML_GLOSSARY, ELML_BIBLIOGRAPHY,
			ELML_METADATA };

	private String[] ElmlLook = { ELML_CLARIFY, ELML_LOOK, ELML_ACT,
			ELML_LEARNINGOBJECT, ELML_SUMMARY, ELML_SELFASSESSMENT,
			ELML_FURTHERREADING, ELML_UNIT, ELML_GLOSSARY, ELML_BIBLIOGRAPHY,
			ELML_METADATA };

	private String[] ElmlAct = { ELML_CLARIFY, ELML_LOOK, ELML_ACT,
			ELML_LEARNINGOBJECT, ELML_SUMMARY, ELML_SELFASSESSMENT,
			ELML_FURTHERREADING, ELML_UNIT, ELML_GLOSSARY, ELML_BIBLIOGRAPHY,
			ELML_METADATA };

	private XParagraphCursor xParaCursor;

	private XTextSection finalElement;

	private String finalElementName;

	private boolean deleteChainMode;

	private Map m;

	private ContentAccess xTextContentAccess;

	private ContentContext xContentContext;

	private XTextDocument xTextDocument;

	private XText xText;

	private boolean glossaryBreak;

	private XEnumeration xTextEnum;

	private Object Portion;

	private XEnumeration xParaEnum;

	private Object innerPortion;

	private String portionType;

	private XEnumeration xPortionEnum;

	private Object textPortion;

	private boolean removeLine;

	public ContentRemove() {
	}

	/**
	 * Remove an element and all of its child elements
	 * 
	 * @param paraName
	 *            the paragraph name of the current section
	 * @param xParaCursorHandle
	 *            the xParaCursor to iterate through the content
	 */

	public void removeElement(String paraName,
			XParagraphCursor xParaCursorHandle) {

		xTextContentAccess = new ContentAccess();
		xContentContext = new ContentContext();
		xParaCursor = xParaCursorHandle;
		finalElement = null;
		finalElementName = null;
		deleteChainMode = true;
		String[] stopElements = null;
		glossaryBreak = false;
		removeLine = false;

		m = new HashMap();
		m.put(ELML_LESSON, Boolean.FALSE);
		m.put(ELML_UNIT, Boolean.FALSE);
		m.put(ELML_ENTRY, Boolean.FALSE);
		m.put(ELML_GOALS, Boolean.FALSE);
		m.put(ELML_LEARNINGOBJECT, Boolean.FALSE);
		m.put(ELML_CLARIFY, Boolean.FALSE);
		m.put(ELML_LOOK, Boolean.FALSE);
		m.put(ELML_ACT, Boolean.FALSE);
		m.put(ELML_SUMMARY, Boolean.FALSE);
		m.put(ELML_UNITSUMMARY, Boolean.FALSE);
		m.put(ELML_SELFASSESSMENT, Boolean.FALSE);
		m.put(ELML_FURTHERREADING, Boolean.FALSE);
		m.put(ELML_GLOSSARY, Boolean.FALSE);
		m.put(ELML_DEFINITION, Boolean.FALSE);
		m.put(ELML_BIBLIOGRAPHY, Boolean.FALSE);
		m.put(ELML_BIBENTRY, Boolean.FALSE);
		m.put(ELML_METADATA, Boolean.FALSE);

		// choose the corresponding element array
		if (paraName.equals(ELML_LESSON)) {
			stopElements = ElmlLesson;
		} else if (paraName.equals(ELML_UNIT)) {
			stopElements = ElmlUnit;
		} else if (paraName.equals(ELML_ENTRY)) {
			stopElements = ElmlEntry;
		} else if (paraName.equals(ELML_GOALS)) {
			stopElements = ElmlGoals;
		} else if (paraName.equals(ELML_LEARNINGOBJECT)) {
			stopElements = ElmlLearningObject;
		} else if (paraName.equals(ELML_CLARIFY)) {
			stopElements = ElmlClarify;
		} else if (paraName.equals(ELML_DEFINITION)) {
			stopElements = ElmlDefinition;
		} else if (paraName.equals(ELML_BIBENTRY)) {
			stopElements = ElmlBibEntry;
		} else if (paraName.equals(ELML_LOOK)) {
			stopElements = ElmlLook;
		} else if (paraName.equals(ELML_ACT)) {
			stopElements = ElmlAct;
		} else if (paraName.equals(ELML_SUMMARY)) {
			stopElements = ElmlSummary;
		} else if (paraName.equals(ELML_UNITSUMMARY)) {
			stopElements = ElmlUnitSummary;
		}

		// initialize HashMap with depending elements of current element
		for (int i = 0; i < stopElements.length; i++) {
			if (m.containsKey(stopElements[i])) {
				m.put(stopElements[i], Boolean.TRUE);
			}
		}

		// get the current startElement and save its name for later
		finalElement = xTextContentAccess.getSection(xParaCursor);
		finalElementName = xTextContentAccess.getSectionName(finalElement);

		xParaCursor.gotoNextParagraph(false); // skip the parent element

		// Create xController in order to get view cursor
		XModel xModel = (XModel) UnoRuntime.queryInterface(XModel.class,
				ElementController.getXComponent());
		XController xController = xModel.getCurrentController();

		// delete while there is content to delete
		while (deleteChainMode) {
			String ParaName = xContentContext.getContext(xParaCursor);
			xParaCursor.gotoStartOfParagraph(false);
			xParaCursor.gotoEndOfParagraph(true);
			if (ParaName.equals(ELML_LESSON)) {
				Boolean level = (Boolean) m.get(ParaName);
				if (level.booleanValue()) {
					removeParent();
				} else {
					removeChild();
				}
			} else if (ParaName.equals(ELML_ENTRY)) {
				Boolean level = (Boolean) m.get(ParaName);
				if (level.booleanValue()) {
					removeParent();
				} else {
					removeChild();
				}
			} else if (ParaName.equals(ELML_GOALS)) {
				Boolean level = (Boolean) m.get(ParaName);
				if (level.booleanValue()) {
					removeParent();
				} else {
					removeChild();
				}
			} else if (ParaName.equals(ELML_UNIT)) {
				Boolean level = (Boolean) m.get(ParaName);
				if (level.booleanValue()) {
					removeParent();
				} else {
					removeChild();
				}
			} else if (ParaName.equals(ELML_LEARNINGOBJECT)) {
				Boolean level = (Boolean) m.get(ParaName);
				if (level.booleanValue()) {
					removeParent();
				} else {
					removeChild();
				}
			} else if (ParaName.equals(ELML_GLOSSARY)) {
				Boolean level = (Boolean) m.get(ParaName);
				if (level.booleanValue()) {
					glossaryBreak = true;
					removeParent();
				} else {
					removeChild();
				}
			} else if (ParaName.equals(ELML_DEFINITION)) {
				Boolean level = (Boolean) m.get(ParaName);
				if (level.booleanValue()) {
					removeLine = true;
					removeParent();
				} else {
					removeChild();
				}
			} else if (ParaName.equals(ELML_BIBENTRY)) {
				Boolean level = (Boolean) m.get(ParaName);
				if (level.booleanValue()) {
					removeLine = true;
					removeParent();
				} else {
					removeChild();
				}
			} else if (ParaName.equals(ELML_CLARIFY)) {
				Boolean level = (Boolean) m.get(ParaName);
				if (level.booleanValue()) {
					removeParent();
				} else {
					removeChild();
				}
			} else if (ParaName.equals(ELML_LOOK)) {
				Boolean level = (Boolean) m.get(ParaName);
				if (level.booleanValue()) {
					removeParent();
				} else {
					removeChild();
				}
			} else if (ParaName.equals(ELML_ACT)) {
				Boolean level = (Boolean) m.get(ParaName);
				if (level.booleanValue()) {
					removeParent();
				} else {
					removeChild();
				}
			} else if (ParaName.equals(ELML_SUMMARY)) {
				Boolean level = (Boolean) m.get(ParaName);
				if (level.booleanValue()) {
					removeParent();
				} else {
					removeChild();
				}
			} else if (ParaName.equals(ELML_UNITSUMMARY)) {
				Boolean level = (Boolean) m.get(ParaName);
				if (level.booleanValue()) {
					removeParent();
				} else {
					removeChild();
				}
			} else if (ParaName.equals(ELML_BIBLIOGRAPHY)) {
				Boolean level = (Boolean) m.get(ParaName);
				if (level.booleanValue()) {
					removeParent();
				} else {
					removeChild();
				}
			} else if (ParaName.equals("ElmlBox")) {
				xParaCursor.setString("");
				xParaCursor.gotoNextParagraph(false);
				xParaCursor.gotoPreviousParagraph(true);
				xParaCursor.setString("");
			} else if (ParaName.equals("ElmlParagraph")) {

				xParaCursor.setString("");

				XEnumerationAccess xTextAccess = (XEnumerationAccess) UnoRuntime
						.queryInterface(XEnumerationAccess.class, xParaCursor);

				xTextEnum = xTextAccess.createEnumeration();

				while (xTextEnum.hasMoreElements()) {
					try {
						Portion = xTextEnum.nextElement();
					} catch (NoSuchElementException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					} catch (WrappedTargetException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}

					XEnumerationAccess xParaAccess = (XEnumerationAccess) UnoRuntime
							.queryInterface(XEnumerationAccess.class, Portion);
					xParaEnum = xParaAccess.createEnumeration();

					while (xParaEnum.hasMoreElements()) {
						try {
							innerPortion = xParaEnum.nextElement();
						} catch (NoSuchElementException e1) {
							// TODO Auto-generated catch block
							e1.printStackTrace();
						} catch (WrappedTargetException e1) {
							// TODO Auto-generated catch block
							e1.printStackTrace();
						}

						XServiceInfo xParaInfo = xTextContentAccess
								.getServiceInfo(innerPortion);

						if (xParaInfo
								.supportsService("com.sun.star.text.TextPortion")) {
							try {
								portionType = xTextContentAccess
										.getPortionType(innerPortion);
							} catch (UnknownPropertyException e) {
								// TODO Auto-generated catch block
								e.printStackTrace();
							} catch (WrappedTargetException e) {
								// TODO Auto-generated catch block
								e.printStackTrace();
							}

							XContentEnumerationAccess xPortionAccess = (XContentEnumerationAccess) UnoRuntime
									.queryInterface(
											XContentEnumerationAccess.class,
											Portion);
							xPortionEnum = xPortionAccess
									.createContentEnumeration("com.sun.star.text.TextContent");

							while (xPortionEnum.hasMoreElements()) {
								try {
									textPortion = xPortionEnum.nextElement();
								} catch (NoSuchElementException e) {
									// TODO Auto-generated catch block
									e.printStackTrace();
								} catch (WrappedTargetException e) {
									// TODO Auto-generated catch block
									e.printStackTrace();
								}
								XServiceInfo xInfo = xTextContentAccess
										.getServiceInfo(textPortion);

								if (xInfo
										.supportsService("com.sun.star.text.TextFrame")) {
									XTextContent newContent = (XTextContent) UnoRuntime
											.queryInterface(XTextContent.class,
													textPortion);
									newContent.dispose();

								} else if (xInfo
										.supportsService("com.sun.star.text.TextGraphicObject")) {
									XTextContent newContent = (XTextContent) UnoRuntime
											.queryInterface(XTextContent.class,
													textPortion);
									newContent.dispose();
								} else if (xInfo
										.supportsService("com.sun.star.text.TextEmbeddedObject")) {
									XTextContent newContent = (XTextContent) UnoRuntime
											.queryInterface(XTextContent.class,
													textPortion);
									newContent.dispose();
								}
							}

							if (portionType.equals("TextTable")) {

							} else {

								xParaCursor.setString("");
								xParaCursor.gotoNextParagraph(false);
								xParaCursor.gotoPreviousParagraph(true);
								xParaCursor.setString("");
							}
						}
					}
				}

			} else {
				xParaCursor.setString("");
				xParaCursor.gotoNextParagraph(false);
				xParaCursor.gotoPreviousParagraph(true);
				xParaCursor.setString("");
			}
		}
	}

	/**
	 * Remove parent element
	 */
	private void removeParent() {
		XTextSection currSect = null;

		currSect = xTextContentAccess.getSection(xParaCursor);
		String currName = xTextContentAccess.getSectionName(currSect);

		xTextDocument = (XTextDocument) UnoRuntime.queryInterface(
				XTextDocument.class, ElementController.getXComponent());
		xText = xTextDocument.getText();

		// check whether this element is the startpoint
		if (finalElementName.equals(currName)) {

			// While there is content inside the section, enumerate it
			XEnumeration xSectEnum = xTextContentAccess
					.createInnerSectionEnum(currSect);

			while (xSectEnum.hasMoreElements()) {
				Object Element = null;
				try {
					Element = xSectEnum.nextElement();
				} catch (NoSuchElementException e3) {
					// TODO Auto-generated catch block
					e3.printStackTrace();
				} catch (WrappedTargetException e3) {
					// TODO Auto-generated catch block
					e3.printStackTrace();
				}
				XServiceInfo xSectionInfo = xTextContentAccess
						.getServiceInfo(Element);

				if (xSectionInfo.supportsService("com.sun.star.text.Paragraph")) {

					XEnumeration xParaEnum = xTextContentAccess
							.createInnerParaEnum(Element);

					// While there is content inside the paragraph, enumerate it
					while (xParaEnum.hasMoreElements()) {
						Object Portion = null;
						try {
							Portion = xParaEnum.nextElement();
						} catch (NoSuchElementException e2) {
							// TODO Auto-generated catch block
							e2.printStackTrace();
						} catch (WrappedTargetException e2) {
							// TODO Auto-generated catch block
							e2.printStackTrace();
						}
						XServiceInfo xParaInfo = xTextContentAccess
								.getServiceInfo(Portion);

						if (xParaInfo
								.supportsService("com.sun.star.text.TextPortion")) {
							String portionType = null;
							try {
								portionType = xTextContentAccess
										.getPortionType(Portion);
							} catch (UnknownPropertyException e1) {
								// TODO Auto-generated catch block
								e1.printStackTrace();
							} catch (WrappedTargetException e1) {
								// TODO Auto-generated catch block
								e1.printStackTrace();
							}

							if (portionType.equals("TextField")) {
								removeTextField(Portion);
							} else if (portionType.equals("Text")) {
								xTextContentAccess
										.setStringPortion(Portion, "");
							}

						}
					}
				}
			}

			try {
				xText.removeTextContent(currSect);
			} catch (NoSuchElementException e) {
				e.printStackTrace();
			}
			// Access the property set of the cursor selection
			XPropertySet xParaProps = (XPropertySet) UnoRuntime.queryInterface(
					XPropertySet.class, xParaCursor);

			// Set the style of the cursor selection to a new style
			try {
				xParaProps.setPropertyValue("ParaStyleName", "ElmlParagraph");
			} catch (UnknownPropertyException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			} catch (PropertyVetoException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			} catch (IllegalArgumentException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			} catch (WrappedTargetException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}

			if (removeLine) {
				xParaCursor.gotoPreviousParagraph(false);
				xParaCursor.gotoEndOfParagraph(false);
				xParaCursor.gotoNextParagraph(true);
				xParaCursor.setString("");
			}

			deleteChainMode = false;

			// ADD FINAL PAGEBREAK IF GLOSSARY TOUCHED
			if (glossaryBreak) {
				XPropertySet xCursorProps = (XPropertySet) UnoRuntime
						.queryInterface(XPropertySet.class, xParaCursor);
				xParaCursor.gotoNextParagraph(false);
				try {
					xCursorProps.setPropertyValue("BreakType",
							BreakType.PAGE_BEFORE);
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
			}

			// Refresh the document
			XRefreshable xRefresh = (XRefreshable) UnoRuntime.queryInterface(
					XRefreshable.class, xTextDocument);
			xRefresh.refresh();

		} else {
			xParaCursor.gotoPreviousParagraph(false); // jump back
		}
	}

	/**
	 * Remove child element
	 */
	public void removeChild() {
		xParaCursor.setString("");
		xParaCursor.gotoPreviousParagraph(false);
		xParaCursor.gotoEndOfParagraph(false);
		xParaCursor.gotoNextParagraph(true);
		xParaCursor.setString("");
		xParaCursor.gotoNextParagraph(false);
	}

	/**
	 * Removes the current paragraph and sets the Cursor style to ElmlParagraph
	 */
	public void removeContent(XParagraphCursor xParaCursor) {
		xParaCursor.setString("");
		xParaCursor.gotoStartOfParagraph(false);
		xParaCursor.gotoEndOfParagraph(true);
		xParaCursor.setString("");
		XPropertySet xCursorProps = (XPropertySet) UnoRuntime.queryInterface(
				XPropertySet.class, xParaCursor);
		try {
			xCursorProps.setPropertyValue("ParaStyleName", "ElmlParagraph");
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
	}

	/**
	 * Remove TextField object including its MasterField if not used anymore
	 * 
	 * @param Portion
	 *            the TextPortion of interest
	 */
	private void removeTextField(Object Portion) {
		Object xDepending = null;
		Object xTextField = xTextContentAccess.getTextField(Portion);

		XDependentTextField xDependentTextField = (XDependentTextField) UnoRuntime
				.queryInterface(XDependentTextField.class, xTextField);

		XTextContent xTextFieldContent = (XTextContent) UnoRuntime
				.queryInterface(XTextContent.class, xDependentTextField);

		XPropertySet xMasterSet = xDependentTextField.getTextFieldMaster();

		try {
			xDepending = xMasterSet.getPropertyValue("DependentTextFields");
		} catch (UnknownPropertyException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		} catch (WrappedTargetException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}

		try {
			xText.removeTextContent(xTextFieldContent);
		} catch (NoSuchElementException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		if (xDepending == null) {
			XComponent xC = (XComponent) UnoRuntime.queryInterface(
					XComponent.class, xMasterSet);
			xC.dispose();
		}
	}

}
