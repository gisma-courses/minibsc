package org.openoffice.addon;

import java.awt.Frame;

import com.sun.star.lang.XComponent;
import com.sun.star.lang.XMultiComponentFactory;
import com.sun.star.uno.Exception;

public class ElementController {

	private static XMultiComponentFactory xMCF;

	public static XComponent xComponent;

	public ElementController() {
	}

	public static void createElement(String element) {
		if (element.equals("ElmlLesson")) {
			ElmlLesson elmlLesson = new ElmlLesson();
			elmlLesson.setContext(xMCF, xComponent, 0);
			elmlLesson.setContent();
			elmlLesson.getDepending();
		} else if (element.equals("ElmlEntry")) {
			ElmlEntry elmlEntry = new ElmlEntry();
			elmlEntry.setContext(xMCF, xComponent, 0);
			elmlEntry.setContent();
			elmlEntry.getDepending();
		} else if (element.equals("ElmlGoals")) {
			ElmlGoals elmlGoals = new ElmlGoals();
			elmlGoals.setContext(xMCF, xComponent, 0);
			elmlGoals.setContent();
			elmlGoals.getDepending();
		} else if (element.equals("ElmlUnit")) {
			ElmlUnit elmlUnit = new ElmlUnit();
			elmlUnit.setContext(xMCF, xComponent, 0);
			elmlUnit.setContent();
			elmlUnit.getDepending();
		} else if (element.equals("ElmlLearningObject")) {
			ElmlLearningObject elmlLearningObject = new ElmlLearningObject();
			elmlLearningObject.setContext(xMCF, xComponent, 0);
			elmlLearningObject.setContent();
			elmlLearningObject.getDepending();
		} else if (element.equals("ElmlClarify")) {
			ElmlClarify elmlClarify = new ElmlClarify();
			elmlClarify.setContext(xMCF, xComponent, 0);
			elmlClarify.setContent();
			elmlClarify.getDepending();
		} else if (element.equals("ElmlLook")) {
			ElmlLook elmlLook = new ElmlLook();
			elmlLook.setContext(xMCF, xComponent, 0);
			elmlLook.setContent();
			elmlLook.getDepending();
		} else if (element.equals("ElmlAct")) {
			ElmlAct elmlAct = new ElmlAct();
			elmlAct.setContext(xMCF, xComponent, 0);
			elmlAct.setContent();
			elmlAct.getDepending();
		} else if (element.equals("ElmlSummary")) {
			ElmlSummary elmlSummary = new ElmlSummary();
			elmlSummary.setContext(xMCF, xComponent, 0);
			elmlSummary.setContent();
			elmlSummary.getDepending();
		} else if (element.equals("ElmlBibEntry")) {
			ElmlBibEntry elmlBibEntry = new ElmlBibEntry();
			elmlBibEntry.setContext(xMCF, xComponent, 0);
			elmlBibEntry.setContent();
			elmlBibEntry.getDepending();
		} else if (element.equals("ElmlGlossary")) {
			ElmlGlossary elmlGlossary = new ElmlGlossary();
			elmlGlossary.setContext(xMCF, xComponent, 0);
			elmlGlossary.setContent();
			elmlGlossary.getDepending();
		} else if (element.equals("ElmlBibliography")) {
			ElmlBibliography elmlBibliography = new ElmlBibliography();
			elmlBibliography.setContext(xMCF, xComponent, 0);
			elmlBibliography.setContent();
			elmlBibliography.getDepending();
		} else if (element.equals("ContentTerm")) {
			ContentTerm contentTerm = new ContentTerm();
			contentTerm.setContext(xMCF, xComponent, 0);
			contentTerm.setContent();
			contentTerm.getDepending();
		} else if (element.equals("ContentCitation")) {
			ContentCitation contentCitation = new ContentCitation();
			contentCitation.setContext(xMCF, xComponent, 0);
			contentCitation.setContent();
			contentCitation.getDepending();
		} else if (element.equals("ElmlBox")) {
			ElmlBox elmlBox = new ElmlBox();
			elmlBox.setContext(xMCF, xComponent, 0);
			elmlBox.setContent();
			elmlBox.getDepending();
		} else {

		}
	}

	public static void editElement(String element) throws Exception {
		if (element.equals("ElmlLesson")) {
			ElmlLesson elmlLesson = new ElmlLesson();
			elmlLesson.setContext(xMCF, xComponent, 1);
			elmlLesson.getContent();
		} else if (element.equals("ElmlEntry")) {
			ElmlEntry elmlEntry = new ElmlEntry();
			elmlEntry.setContext(xMCF, xComponent, 1);
			elmlEntry.getContent();
		} else if (element.equals("ElmlGoals")) {
			ElmlGoals elmlGoals = new ElmlGoals();
			elmlGoals.setContext(xMCF, xComponent, 1);
			elmlGoals.getContent();
		} else if (element.equals("ElmlUnit")) {
			ElmlUnit elmlUnit = new ElmlUnit();
			elmlUnit.setContext(xMCF, xComponent, 1);
			elmlUnit.getContent();
		} else if (element.equals("ElmlLearningObject")) {
			ElmlLearningObject elmlLearningObject = new ElmlLearningObject();
			elmlLearningObject.setContext(xMCF, xComponent, 1);
			elmlLearningObject.getContent();
		} else if (element.equals("ElmlClarify")) {
			ElmlClarify elmlClarify = new ElmlClarify();
			elmlClarify.setContext(xMCF, xComponent, 1);
			elmlClarify.getContent();
		} else if (element.equals("ElmlLook")) {
			ElmlLook elmlLook = new ElmlLook();
			elmlLook.setContext(xMCF, xComponent, 1);
			elmlLook.getContent();
		} else if (element.equals("ElmlAct")) {
			ElmlAct elmlAct = new ElmlAct();
			elmlAct.setContext(xMCF, xComponent, 1);
			elmlAct.getContent();
		} else if (element.equals("ElmlSummary")) {
			ElmlSummary elmlSummary = new ElmlSummary();
			elmlSummary.setContext(xMCF, xComponent, 1);
			elmlSummary.getContent();
		} else if (element.equals("ElmlBibEntry")) {
			ElmlBibEntry elmlBibEntry = new ElmlBibEntry();
			elmlBibEntry.setContext(xMCF, xComponent, 1);
			elmlBibEntry.getContent();
		} else if (element.equals("ElmlGlossary")) {
			ElmlGlossary elmlGlossary = new ElmlGlossary();
			elmlGlossary.setContext(xMCF, xComponent, 1);
			elmlGlossary.getContent();
		} else if (element.equals("ContentTerm")) {
			ContentTerm contentTerm = new ContentTerm();
			contentTerm.setContext(xMCF, xComponent, 1);
			contentTerm.getContent();
		} else if (element.equals("ContentCitation")) {
			ContentCitation contentCitation = new ContentCitation();
			contentCitation.setContext(xMCF, xComponent, 1);
			contentCitation.getContent();
		} else if (element.equals("ElmlDefinition")) {
			ContentTerm contentTerm = new ContentTerm();
			contentTerm.setContext(xMCF, xComponent, 1);
			contentTerm.getContent();
		} else if (element.equals("ElmlBibliography")) {
			ElmlBibliography elmlBibliography = new ElmlBibliography();
			elmlBibliography.setContext(xMCF, xComponent, 1);
			elmlBibliography.getContent();
		} else if (element.equals("Tabledata")) {
			ContTabledata contTabledata = new ContTabledata();
			contTabledata.setContext(xMCF, xComponent, 1);
			contTabledata.getContent();
		} else if (element.equals("ElmlBox")) {
			ElmlBox elmlBox = new ElmlBox();
			elmlBox.setContext(xMCF, xComponent, 1);
			elmlBox.getContent();
		} else {
			MsgBox message = new MsgBox(new Frame(""),
					"Kein Kontext zum editieren.", false);
		}
	}

	public static void deleteElement(String element) {
		if (element.equals("ElmlLesson")) {
			ElmlLesson elmlLesson = new ElmlLesson();
			elmlLesson.setContext(xMCF, xComponent, 2);
			elmlLesson.deleteContent();
		} else if (element.equals("ElmlEntry")) {
			ElmlEntry elmlEntry = new ElmlEntry();
			elmlEntry.setContext(xMCF, xComponent, 2);
			elmlEntry.deleteContent();
		} else if (element.equals("ElmlGoals")) {
			ElmlGoals elmlGoals = new ElmlGoals();
			elmlGoals.setContext(xMCF, xComponent, 2);
			elmlGoals.deleteContent();
		} else if (element.equals("ElmlUnit")) {
			ElmlUnit elmlUnit = new ElmlUnit();
			elmlUnit.setContext(xMCF, xComponent, 2);
			elmlUnit.deleteContent();
		} else if (element.equals("ElmlLearningObject")) {
			ElmlLearningObject elmlLearningObject = new ElmlLearningObject();
			elmlLearningObject.setContext(xMCF, xComponent, 2);
			elmlLearningObject.deleteContent();
		} else if (element.equals("ElmlClarify")) {
			ElmlClarify elmlClarify = new ElmlClarify();
			elmlClarify.setContext(xMCF, xComponent, 2);
			elmlClarify.deleteContent();
		} else if (element.equals("ElmlLook")) {
			ElmlLook elmlLook = new ElmlLook();
			elmlLook.setContext(xMCF, xComponent, 2);
			elmlLook.deleteContent();
		} else if (element.equals("ElmlAct")) {
			ElmlAct elmlAct = new ElmlAct();
			elmlAct.setContext(xMCF, xComponent, 2);
			elmlAct.deleteContent();
		} else if (element.equals("ElmlSummary")) {
			ElmlSummary elmlSummary = new ElmlSummary();
			elmlSummary.setContext(xMCF, xComponent, 2);
			elmlSummary.deleteContent();
		} else if (element.equals("ElmlBibEntry")) {
			ElmlBibEntry elmlBibEntry = new ElmlBibEntry();
			elmlBibEntry.setContext(xMCF, xComponent, 2);
			elmlBibEntry.deleteContent();
		} else if (element.equals("ElmlGlossary")) {
			MsgBox message = new MsgBox(new Frame(""),
					"Glossar kann nicht gelöscht werden.", false);
		} else if (element.equals("ElmlDefinition")) {
			ContentTerm contentTerm = new ContentTerm();
			contentTerm.setContext(xMCF, xComponent, 2);
			contentTerm.deleteContent();
		} else if (element.equals("ContentTerm")) {
			ContentTerm contentTerm = new ContentTerm();
			contentTerm.setContext(xMCF, xComponent, 2);
			contentTerm.deleteContent();
		} else if (element.equals("ContentCitation")) {
			ContentCitation contentCitation = new ContentCitation();
			contentCitation.setContext(xMCF, xComponent, 2);
			contentCitation.deleteContent();
		} else if (element.equals("ElmlBox")) {
			ElmlBox elmlBox = new ElmlBox();
			elmlBox.setContext(xMCF, xComponent, 2);
			elmlBox.deleteContent();
		} else if (element.equals("ElmlBibliography")) {
			MsgBox message = new MsgBox(new Frame(""),
					"Bibliographie kann nicht gelöscht werden.", false);
		} else {
			MsgBox message = new MsgBox(new Frame(""),
					"Kein Kontext zum löschen.", false);
		}
	}

	public static void createContext(XMultiComponentFactory xMultiCF,
			XComponent xC) {
		xMCF = xMultiCF;
		xComponent = xC;
	}

	public static XComponent getXComponent() {
		return xComponent;
	}

	public static XMultiComponentFactory getXMCF() {
		return xMCF;
	}

}
