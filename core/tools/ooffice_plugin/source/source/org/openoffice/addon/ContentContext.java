/*
 * ContentContext.java
 * 
 * Helper class to identify current Cursor location
 * 
 * @author      André Locher
 * @version     1.0
 * @since       1.0
 * 
 */

package org.openoffice.addon;

import java.awt.Frame;

import com.sun.star.beans.UnknownPropertyException;
import com.sun.star.beans.XPropertySet;
import com.sun.star.container.NoSuchElementException;
import com.sun.star.container.XEnumeration;
import com.sun.star.container.XEnumerationAccess;
import com.sun.star.container.XIndexAccess;
import com.sun.star.frame.XController;
import com.sun.star.frame.XModel;
import com.sun.star.lang.IndexOutOfBoundsException;
import com.sun.star.lang.WrappedTargetException;
import com.sun.star.lang.XComponent;
import com.sun.star.lang.XServiceInfo;
import com.sun.star.text.XParagraphCursor;
import com.sun.star.text.XText;
import com.sun.star.text.XTextContent;
import com.sun.star.text.XTextCursor;
import com.sun.star.text.XTextDocument;
import com.sun.star.text.XTextRange;
import com.sun.star.text.XTextTable;
import com.sun.star.text.XTextTableCursor;
import com.sun.star.text.XTextViewCursor;
import com.sun.star.text.XTextViewCursorSupplier;
import com.sun.star.uno.UnoRuntime;
import com.sun.star.uno.XComponentContext;
import com.sun.star.uno.XInterface;

public class ContentContext {

	private XTextDocument xTextDocument;

	private XText xText;

	private XTextCursor xModelCursor;

	private XParagraphCursor xParaCursor;

	private XPropertySet xCursorProperties;

	private String ParaName;

	public ContentContext() {
	}

	/**
	 * Checks the ParagraphStyle of the current cursor location if no cursor has
	 * been initialized yet
	 * 
	 * @param currentComponent
	 *            the current component on which we can build the cursor
	 * @return String ParagraphStyle of the current cursor location
	 */
	public String getContext(XComponent currentComponent) {
		ParaName = "";
		xModelCursor = null;

		xTextDocument = (XTextDocument) UnoRuntime.queryInterface(
				XTextDocument.class, currentComponent);
		xText = xTextDocument.getText();

		// Create xController in order to get view cursor
		XModel xModel = (XModel) UnoRuntime.queryInterface(XModel.class,
				currentComponent);
		XController xController = xModel.getCurrentController();

		// the controller gives us the TextViewCursor
		XTextViewCursorSupplier xViewCursorSupplier = (XTextViewCursorSupplier) UnoRuntime
				.queryInterface(XTextViewCursorSupplier.class, xController);
		XTextViewCursor xViewCursor = xViewCursorSupplier.getViewCursor();

		try {

			xModelCursor = xText.createTextCursorByRange(xViewCursor.getEnd());

			xParaCursor = (XParagraphCursor) UnoRuntime.queryInterface(
					XParagraphCursor.class, xModelCursor);

			// Access the property set of the cursor selection
			xCursorProperties = (XPropertySet) UnoRuntime.queryInterface(
					XPropertySet.class, xParaCursor);

			try {
				ParaName = (String) xCursorProperties
						.getPropertyValue("ParaStyleName");
			} catch (UnknownPropertyException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (WrappedTargetException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} catch (Exception e) {

		}

		if (ParaName.equals("")) {

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

				XTextRange xRange = null;
				try {
					xRange = (XTextRange) UnoRuntime.queryInterface(
							XTextRange.class, xRangeAccess.getByIndex(0));
				} catch (IndexOutOfBoundsException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} catch (WrappedTargetException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}

				XEnumerationAccess xTextRangeAccess = (XEnumerationAccess) UnoRuntime
						.queryInterface(XEnumerationAccess.class, xRange);
				XEnumeration xEnum = xTextRangeAccess.createEnumeration();

				while (xEnum.hasMoreElements()) {
					XServiceInfo xInfo = null;
					Object content = null;
					try {
						content = xEnum.nextElement();
					} catch (NoSuchElementException e1) {
						// TODO Auto-generated catch block
						e1.printStackTrace();
					} catch (WrappedTargetException e1) {
						// TODO Auto-generated catch block
						e1.printStackTrace();
					}
					
					xInfo = (XServiceInfo) UnoRuntime.queryInterface(
							XServiceInfo.class, content);

					if (xInfo.supportsService("com.sun.star.text.TextTable")) {
						ParaName = "Tabledata";
						return ParaName;
					} else if (xInfo.supportsService("com.sun.star.text.Paragraph")) {
						ParaName = "ElmlBox";
						return ParaName;
					}
				}
			}

			if (xServInfo
					.supportsService("com.sun.star.text.TextGraphicObject")) {
				ParaName = "Graphic";
			}
		}
		return ParaName;
	}

	/**
	 * Checks the ParagraphStyle of the current cursor location
	 * 
	 * @param xParaCursor
	 *            the XParagraphCursor
	 * @return String ParagraphStyle of the current cursor location
	 */
	public String getContext(XParagraphCursor xParaCursor) {

		// Access the property set of the cursor selection
		xCursorProperties = (XPropertySet) UnoRuntime.queryInterface(
				XPropertySet.class, xParaCursor);

		ParaName = "";

		try {
			ParaName = (String) xCursorProperties
					.getPropertyValue("ParaStyleName");
		} catch (UnknownPropertyException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (WrappedTargetException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return ParaName;
	}
}
