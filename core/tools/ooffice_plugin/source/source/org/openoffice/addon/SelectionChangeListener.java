package org.openoffice.addon;

import java.awt.Frame;
import java.util.HashMap;
import java.util.Iterator;

import com.sun.star.frame.FeatureStateEvent;
import com.sun.star.frame.XStatusListener;
import com.sun.star.lang.EventObject;
import com.sun.star.view.XSelectionChangeListener;

public class SelectionChangeListener implements XSelectionChangeListener {

	static String ELML_LESSON = "ElmlLesson";

	static String ELML_UNIT = "ElmlUnit";

	static String ELML_ENTRY = "ElmlEntry";

	static String ELML_GOALS = "ElmlGoals";

	static String ELML_LEARNINGOBJECT = "ElmlLearningObject";

	static String ELML_CLARIFY = "ElmlClarify";

	static String ELML_LOOK = "ElmlLook";

	static String ELML_ACT = "ElmlAct";

	static String ELML_SUMMARY = "ElmlSummary";

	static String ELML_SELFASSESSMENT = "ElmlSelfAssessment";

	static String ELML_FURTHERREADING = "ElmlFurtherReading";

	static String ELML_GLOSSARY = "ElmlGlossary";

	static String ELML_BIBLIOGRAPHY = "ElmlBibliography";

	static String ELML_METADATA = "ElmlMetadata";

	static String ELML_TERM = "ContentTerm";
	
	static String ELML_BOX = "ElmlBox";

	private XStatusListener listener;

	public void selectionChanged(EventObject arg0) {

		ContentContext cc = new ContentContext();
		String currentPara = null;

		// get registered Listeners from DispatchProvider
		HashMap registeredListeners = ElmlEditor.registeredListeners;

		FeatureStateEvent stateEnable = new FeatureStateEvent();
		stateEnable.IsEnabled = true;
		stateEnable.State = Boolean.FALSE;

		FeatureStateEvent stateDisable = new FeatureStateEvent();
		stateDisable.IsEnabled = false;
		stateDisable.State = Boolean.FALSE;
		
		currentPara = cc.getContext(ElementController.getXComponent());

		if (registeredListeners != null && currentPara != null) {

			if (currentPara.equals(ELML_LESSON)) {

				listener = (XStatusListener) registeredListeners.get(ELML_UNIT);
				listener.statusChanged(stateDisable);
				listener = (XStatusListener) registeredListeners
						.get(ELML_LEARNINGOBJECT);
				listener.statusChanged(stateDisable);
				listener = (XStatusListener) registeredListeners
						.get(ELML_CLARIFY);
				listener.statusChanged(stateDisable);
				listener = (XStatusListener) registeredListeners.get(ELML_LOOK);
				listener.statusChanged(stateDisable);
				listener = (XStatusListener) registeredListeners.get(ELML_ACT);
				listener.statusChanged(stateDisable);
				listener = (XStatusListener) registeredListeners
						.get(ELML_SUMMARY);
				listener.statusChanged(stateDisable);
				listener = (XStatusListener) registeredListeners.get(ELML_TERM);
				listener.statusChanged(stateDisable);
				listener = (XStatusListener) registeredListeners.get(ELML_BOX);
				listener.statusChanged(stateDisable);

			} else if (currentPara.equals(ELML_UNIT)) {
				listener = (XStatusListener) registeredListeners.get(ELML_UNIT);
				listener.statusChanged(stateEnable);
				listener = (XStatusListener) registeredListeners
						.get(ELML_LEARNINGOBJECT);
				listener.statusChanged(stateDisable);
				listener = (XStatusListener) registeredListeners
						.get(ELML_CLARIFY);
				listener.statusChanged(stateDisable);
				listener = (XStatusListener) registeredListeners.get(ELML_LOOK);
				listener.statusChanged(stateDisable);
				listener = (XStatusListener) registeredListeners.get(ELML_ACT);
				listener.statusChanged(stateDisable);
				listener = (XStatusListener) registeredListeners
						.get(ELML_SUMMARY);
				listener.statusChanged(stateEnable);
				listener = (XStatusListener) registeredListeners.get(ELML_TERM);
				listener.statusChanged(stateDisable);
				listener = (XStatusListener) registeredListeners.get(ELML_BOX);
				listener.statusChanged(stateDisable);

			} else if (currentPara.equals(ELML_LEARNINGOBJECT)) {
				XStatusListener listener = (XStatusListener) registeredListeners
						.get(ELML_LEARNINGOBJECT);
				listener.statusChanged(stateEnable);
				listener = (XStatusListener) registeredListeners
						.get(ELML_CLARIFY);
				listener.statusChanged(stateEnable);
				listener = (XStatusListener) registeredListeners.get(ELML_LOOK);
				listener.statusChanged(stateEnable);
				listener = (XStatusListener) registeredListeners.get(ELML_ACT);
				listener.statusChanged(stateEnable);
				listener = (XStatusListener) registeredListeners.get(ELML_UNIT);
				listener.statusChanged(stateDisable);
				listener = (XStatusListener) registeredListeners
						.get(ELML_SUMMARY);
				listener.statusChanged(stateDisable);
				listener = (XStatusListener) registeredListeners.get(ELML_TERM);
				listener.statusChanged(stateDisable);
				listener = (XStatusListener) registeredListeners.get(ELML_BOX);
				listener.statusChanged(stateDisable);

			} else if (currentPara.equals(ELML_CLARIFY)) {
				XStatusListener listener = (XStatusListener) registeredListeners
						.get(ELML_CLARIFY);
				listener.statusChanged(stateEnable);
				listener = (XStatusListener) registeredListeners.get(ELML_LOOK);
				listener.statusChanged(stateEnable);
				listener = (XStatusListener) registeredListeners.get(ELML_ACT);
				listener.statusChanged(stateEnable);
				listener = (XStatusListener) registeredListeners
						.get(ELML_LEARNINGOBJECT);
				listener.statusChanged(stateDisable);
				listener = (XStatusListener) registeredListeners.get(ELML_UNIT);
				listener.statusChanged(stateDisable);
				listener = (XStatusListener) registeredListeners
						.get(ELML_SUMMARY);
				listener.statusChanged(stateDisable);
				listener = (XStatusListener) registeredListeners.get(ELML_TERM);
				listener.statusChanged(stateDisable);
				listener = (XStatusListener) registeredListeners.get(ELML_BOX);
				listener.statusChanged(stateDisable);

			} else if (currentPara.equals("ElmlParagraph")) {
				listener = (XStatusListener) registeredListeners
						.get(ELML_LESSON);
				listener.statusChanged(stateEnable);
				listener = (XStatusListener) registeredListeners.get(ELML_UNIT);
				listener.statusChanged(stateEnable);
				listener = (XStatusListener) registeredListeners
						.get(ELML_LEARNINGOBJECT);
				listener.statusChanged(stateEnable);
				listener = (XStatusListener) registeredListeners
						.get(ELML_CLARIFY);
				listener.statusChanged(stateEnable);
				listener = (XStatusListener) registeredListeners.get(ELML_LOOK);
				listener.statusChanged(stateEnable);
				listener = (XStatusListener) registeredListeners.get(ELML_ACT);
				listener.statusChanged(stateEnable);
				listener = (XStatusListener) registeredListeners
						.get(ELML_SUMMARY);
				listener.statusChanged(stateEnable);
				listener = (XStatusListener) registeredListeners.get(ELML_TERM);
				listener.statusChanged(stateEnable);
				listener = (XStatusListener) registeredListeners.get(ELML_BOX);
				listener.statusChanged(stateEnable);

			} else if (currentPara.equals(ELML_ENTRY)) {
				listener = (XStatusListener) registeredListeners
						.get(ELML_LESSON);
				listener.statusChanged(stateEnable);
				listener = (XStatusListener) registeredListeners.get(ELML_UNIT);
				listener.statusChanged(stateDisable);
				listener = (XStatusListener) registeredListeners
						.get(ELML_LEARNINGOBJECT);
				listener.statusChanged(stateDisable);
				listener = (XStatusListener) registeredListeners
						.get(ELML_CLARIFY);
				listener.statusChanged(stateDisable);
				listener = (XStatusListener) registeredListeners.get(ELML_LOOK);
				listener.statusChanged(stateDisable);
				listener = (XStatusListener) registeredListeners.get(ELML_ACT);
				listener.statusChanged(stateDisable);
				listener = (XStatusListener) registeredListeners
						.get(ELML_SUMMARY);
				listener.statusChanged(stateDisable);
				listener = (XStatusListener) registeredListeners.get(ELML_TERM);
				listener.statusChanged(stateDisable);
				listener = (XStatusListener) registeredListeners.get(ELML_BOX);
				listener.statusChanged(stateDisable);

			} else if (currentPara.equals(ELML_GOALS)) {
				listener = (XStatusListener) registeredListeners
						.get(ELML_LESSON);
				listener.statusChanged(stateEnable);
				listener = (XStatusListener) registeredListeners.get(ELML_UNIT);
				listener.statusChanged(stateDisable);
				listener = (XStatusListener) registeredListeners
						.get(ELML_LEARNINGOBJECT);
				listener.statusChanged(stateDisable);
				listener = (XStatusListener) registeredListeners
						.get(ELML_CLARIFY);
				listener.statusChanged(stateDisable);
				listener = (XStatusListener) registeredListeners.get(ELML_LOOK);
				listener.statusChanged(stateDisable);
				listener = (XStatusListener) registeredListeners.get(ELML_ACT);
				listener.statusChanged(stateDisable);
				listener = (XStatusListener) registeredListeners
						.get(ELML_SUMMARY);
				listener.statusChanged(stateDisable);
				listener = (XStatusListener) registeredListeners.get(ELML_TERM);
				listener.statusChanged(stateDisable);
				listener = (XStatusListener) registeredListeners.get(ELML_BOX);
				listener.statusChanged(stateDisable);
				
			} else if (currentPara.equals(ELML_GLOSSARY)) {

				listener = (XStatusListener) registeredListeners.get(ELML_UNIT);
				listener.statusChanged(stateDisable);
				listener = (XStatusListener) registeredListeners
						.get(ELML_LEARNINGOBJECT);
				listener.statusChanged(stateDisable);
				listener = (XStatusListener) registeredListeners
						.get(ELML_CLARIFY);
				listener.statusChanged(stateDisable);
				listener = (XStatusListener) registeredListeners.get(ELML_LOOK);
				listener.statusChanged(stateDisable);
				listener = (XStatusListener) registeredListeners.get(ELML_ACT);
				listener.statusChanged(stateDisable);
				listener = (XStatusListener) registeredListeners
						.get(ELML_SUMMARY);
				listener.statusChanged(stateDisable);
				listener = (XStatusListener) registeredListeners.get(ELML_TERM);
				listener.statusChanged(stateDisable);
				listener = (XStatusListener) registeredListeners.get(ELML_BOX);
				listener.statusChanged(stateDisable);
				
			} else if (currentPara.equals(ELML_BIBLIOGRAPHY)) {

				listener = (XStatusListener) registeredListeners.get(ELML_UNIT);
				listener.statusChanged(stateDisable);
				listener = (XStatusListener) registeredListeners
						.get(ELML_LEARNINGOBJECT);
				listener.statusChanged(stateDisable);
				listener = (XStatusListener) registeredListeners
						.get(ELML_CLARIFY);
				listener.statusChanged(stateDisable);
				listener = (XStatusListener) registeredListeners.get(ELML_LOOK);
				listener.statusChanged(stateDisable);
				listener = (XStatusListener) registeredListeners.get(ELML_ACT);
				listener.statusChanged(stateDisable);
				listener = (XStatusListener) registeredListeners
						.get(ELML_SUMMARY);
				listener.statusChanged(stateDisable);
				listener = (XStatusListener) registeredListeners.get(ELML_TERM);
				listener.statusChanged(stateDisable);
				listener = (XStatusListener) registeredListeners.get(ELML_BOX);
				listener.statusChanged(stateDisable);
				
			} else if (currentPara.equals("ElmlDefinition")) {

				listener = (XStatusListener) registeredListeners.get(ELML_UNIT);
				listener.statusChanged(stateDisable);
				listener = (XStatusListener) registeredListeners
						.get(ELML_LEARNINGOBJECT);
				listener.statusChanged(stateDisable);
				listener = (XStatusListener) registeredListeners
						.get(ELML_CLARIFY);
				listener.statusChanged(stateDisable);
				listener = (XStatusListener) registeredListeners.get(ELML_LOOK);
				listener.statusChanged(stateDisable);
				listener = (XStatusListener) registeredListeners.get(ELML_ACT);
				listener.statusChanged(stateDisable);
				listener = (XStatusListener) registeredListeners
						.get(ELML_SUMMARY);
				listener.statusChanged(stateDisable);
				listener = (XStatusListener) registeredListeners.get(ELML_TERM);
				listener.statusChanged(stateDisable);
				listener = (XStatusListener) registeredListeners.get(ELML_BOX);
				listener.statusChanged(stateDisable);
				
			} else if (currentPara.equals("ElmlBibEntry")) {

				listener = (XStatusListener) registeredListeners.get(ELML_UNIT);
				listener.statusChanged(stateDisable);
				listener = (XStatusListener) registeredListeners
						.get(ELML_LEARNINGOBJECT);
				listener.statusChanged(stateDisable);
				listener = (XStatusListener) registeredListeners
						.get(ELML_CLARIFY);
				listener.statusChanged(stateDisable);
				listener = (XStatusListener) registeredListeners.get(ELML_LOOK);
				listener.statusChanged(stateDisable);
				listener = (XStatusListener) registeredListeners.get(ELML_ACT);
				listener.statusChanged(stateDisable);
				listener = (XStatusListener) registeredListeners
						.get(ELML_SUMMARY);
				listener.statusChanged(stateDisable);
				listener = (XStatusListener) registeredListeners.get(ELML_TERM);
				listener.statusChanged(stateDisable);
				listener = (XStatusListener) registeredListeners.get(ELML_BOX);
				listener.statusChanged(stateDisable);

			} else { // enable all
				Iterator myVeryOwnIterator = registeredListeners.values()
						.iterator();
				while (myVeryOwnIterator.hasNext()) {
					listener = (XStatusListener) myVeryOwnIterator.next();
					listener.statusChanged(stateEnable);
				}
			}

		}
	}

	public void disposing(EventObject arg0) {

	}

}
