package org.openoffice.addon;

import java.awt.Frame;

import com.sun.star.awt.XDialog;
import com.sun.star.awt.XWindow;
import com.sun.star.frame.XController;
import com.sun.star.frame.XModel;
import com.sun.star.lang.XComponent;
import com.sun.star.lang.XMultiComponentFactory;
import com.sun.star.lang.XMultiServiceFactory;
import com.sun.star.text.XParagraphCursor;
import com.sun.star.text.XText;
import com.sun.star.text.XTextCursor;
import com.sun.star.text.XTextDocument;
import com.sun.star.text.XTextSection;
import com.sun.star.text.XTextViewCursor;
import com.sun.star.text.XTextViewCursorSupplier;
import com.sun.star.uno.Exception;
import com.sun.star.uno.UnoRuntime;
import com.sun.star.uno.XComponentContext;

public class Elements {

	public XComponent xComponent;

	public XTextDocument xTextDocument;

	public XText xText;

	public XModel xModel;

	public XController xController;

	public XTextViewCursor xViewCursor;

	public XTextCursor xModelCursor;

	public XTextViewCursorSupplier xViewCursorSupplier;

	public XParagraphCursor xParaCursor;

	public XMultiComponentFactory xMCF;

	public Object dialogModel;

	public XComponentContext xComponentContext;

	public Object dialog;

	public XWindow xWindow;

	public XDialog xDialog;

	public Object attrNavTitle;

	public XTextSection attrLabel;

	public Object attrTitle;

	public int popupDialog = 1;

	public int ModeSet;

	public ContentFactory xContentFactory;

	public ContentAccess xContentAccess;

	public ContentContext xContentContext;

	public DialogController xDialogController;
	
	public String attrNavTitleValue;

	public String attrLabelValue;

	public String attrTitleValue;
	
	public String visibilityAtt;

	public static XMultiServiceFactory mxDocFactory;

	public static final int MODE_NEW = 0;

	public static final int MODE_EDIT = 1;

	public static final int MODE_DELETE = 2;

	public static final int MODE_CANCEL = 3;
	
	public boolean firstContact = false;

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
		
		xModelCursor = xText.createTextCursorByRange(xViewCursor.getEnd());
		xParaCursor = (XParagraphCursor) UnoRuntime.queryInterface(
				XParagraphCursor.class, xModelCursor);
		setMode(mode);
		
		xContentFactory = new ContentFactory();
		xContentAccess = new ContentAccess();
		xContentContext = new ContentContext();
		
	}

	public void addContent(String label, String title, String navTitle) {
	}

	public void editContent(String label, String title, String navTitle) {
	}

	public void setContent() {
		if (popupDialog == 1) {
			try {
				createDialog("", "", "");
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else {
			addContent("", "", "");
		}
	}

	public void getContent() throws Exception {
		createDialog("", "", "");
	}

	public void deleteContent() {
		ContentRemove xTextContentRemover = new ContentRemove();
		String ParaName = xContentContext.getContext(xParaCursor);
		xTextContentRemover.removeElement(ParaName, xParaCursor);
	}

	public void getDepending() {
	}

	public void validateInput() {
		if (ModeSet == MODE_NEW) {
			xDialogController.closeDialog();
		} else if (ModeSet == MODE_EDIT) {
			xDialogController.closeDialog();
		}
	}

	public void validate(String name) {

	}

	public void createDialog(String elementTitle, String elementLabel,
			String elementNavTitle) throws Exception {
		xDialogController = new DialogController(this); // add this object
		xDialogController.setWindowProperties("Test",100,100,170,140);
		xDialogController.showDialog();
	}

	public void setMode(int i) {
		ModeSet = i;
	}
}
