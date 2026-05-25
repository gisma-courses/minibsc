/*
 * ContentFactory.java
 * 
 * Helper class to create TextContent Objects
 * 
 * @author      André Locher
 * @version     1.0
 * @since       1.0
 * 
 */

package org.openoffice.addon;

import com.sun.star.beans.PropertyVetoException;
import com.sun.star.beans.UnknownPropertyException;
import com.sun.star.beans.XPropertySet;
import com.sun.star.container.NoSuchElementException;
import com.sun.star.container.XNameAccess;
import com.sun.star.container.XNamed;
import com.sun.star.lang.IllegalArgumentException;
import com.sun.star.lang.WrappedTargetException;
import com.sun.star.lang.XMultiServiceFactory;
import com.sun.star.text.SetVariableType;
import com.sun.star.text.TextContentAnchorType;
import com.sun.star.text.WrapTextMode;
import com.sun.star.text.XDependentTextField;
import com.sun.star.text.XTextContent;
import com.sun.star.text.XTextFieldsSupplier;
import com.sun.star.text.XTextFrame;
import com.sun.star.uno.Exception;
import com.sun.star.uno.UnoRuntime;

public class ContentFactory {

	public XMultiServiceFactory mxDocFactory;

	private static int LOCKED = 1;

	/**
	 * Creates a new section object and return its XTextContent
	 * 
	 * @param title
	 *            the name of the new section
	 * @param sectionMode
	 *            the location of the image, relative to the url argument
	 * @return XTextContent of the newly created section object
	 */
	public XTextContent createSection(String title, int sectionMode)
			throws Exception {

		mxDocFactory = Elements.mxDocFactory;

		XNamed xChildNamed = (XNamed) UnoRuntime.queryInterface(XNamed.class,
				mxDocFactory.createInstance("com.sun.star.text.TextSection"));

		xChildNamed.setName(title);

		if (sectionMode == LOCKED) {
			XPropertySet xSectionSet = (XPropertySet) UnoRuntime
					.queryInterface(XPropertySet.class, xChildNamed);
			xSectionSet.setPropertyValue("IsProtected", Boolean.TRUE);
		} else {
		}

		XTextContent xSection = (XTextContent) UnoRuntime.queryInterface(
				XTextContent.class, xChildNamed);

		return xSection;
	}

	/**
	 * Creates a new textframe and return its XTextContent
	 * 
	 * @param title
	 *            the name of the new section
	 * @param sectionMode
	 *            the location of the image, relative to the url argument
	 * @return XTextContent of the newly created section object
	 */
	public XTextContent createTextFrame() throws Exception {

		mxDocFactory = Elements.mxDocFactory;

		Object TextFrame = mxDocFactory
				.createInstance("com.sun.star.text.TextFrame");

		XTextFrame xTextFrame = (XTextFrame) UnoRuntime.queryInterface(
				XTextFrame.class, TextFrame);
		
		XTextContent xTextContent = (XTextContent) UnoRuntime.queryInterface(
				XTextContent.class, xTextFrame);
		
		XPropertySet xFrameSet = (XPropertySet) UnoRuntime.queryInterface(
				XPropertySet.class, xTextContent);
		//xFrameSet.setPropertyValue("BackColor", new Integer(13421823));
		xFrameSet.setPropertyValue("RelativeWidth", new Short((short) 100));
		xFrameSet.setPropertyValue("HoriOrient",  new Short((short) 0));
		xFrameSet.setPropertyValue("PositionProtected", Boolean.TRUE);
		xFrameSet.setPropertyValue("SizeProtected", Boolean.TRUE);
		xFrameSet.setPropertyValue("Surround", WrapTextMode.NONE);
		//xFrameSet.setPropertyValue("AnchorType", TextContentAnchorType.AT_CHARACTER);

		return xTextContent;
	}

	/**
	 * Creates a new Bookmark object and returns its XTextContent
	 * 
	 * @param label
	 *            the name of the new bookmark
	 * @return XTextContent of the newly created bookmark object
	 */
	public XTextContent createBookmark(String label) throws Exception {
		mxDocFactory = ElmlLesson.mxDocFactory;

		Object bookmark = mxDocFactory
				.createInstance("com.sun.star.text.Bookmark");

		XNamed xNamed = (XNamed) UnoRuntime.queryInterface(XNamed.class,
				bookmark);
		xNamed.setName(label);

		XTextContent xBookmark = (XTextContent) UnoRuntime.queryInterface(
				XTextContent.class, bookmark);

		return xBookmark;
	}

	/**
	 * Creates a new DependentTextField and returns its XTextContent
	 * 
	 * @param key
	 *            the name of the new variable
	 * @param value
	 *            the value to set for the the new variable
	 * 
	 * @return XTextContent of the newly created DependentTextField object
	 */
	public XTextContent createTextField(String key, String value) {
		mxDocFactory = ElmlLesson.mxDocFactory;
		XDependentTextField xUserField = null;
		XPropertySet xMasterPropSet = null;

		// see if the master already exists otherwise create it
		XTextFieldsSupplier xFieldSupplier = (XTextFieldsSupplier) UnoRuntime
				.queryInterface(XTextFieldsSupplier.class, mxDocFactory);

		XNameAccess xNamedFields = xFieldSupplier.getTextFieldMasters();

		if (xNamedFields != null) {
			try {
				Object xMasterField = xNamedFields
						.getByName("com.sun.star.text.FieldMaster.SetExpression."
								+ key);
				xMasterPropSet = (XPropertySet) UnoRuntime.queryInterface(
						XPropertySet.class, xMasterField);

			} catch (NoSuchElementException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (WrappedTargetException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}

		if (xMasterPropSet == null) {
			try {
				xMasterPropSet = (XPropertySet) UnoRuntime
						.queryInterface(
								XPropertySet.class,
								mxDocFactory
										.createInstance("com.sun.star.text.FieldMaster.SetExpression"));
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

			try {
				xMasterPropSet.setPropertyValue("Name", key);
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
			try {
				xMasterPropSet.setPropertyValue("SubType",
						new Short(SetVariableType.STRING));
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
		}

		// create DependentTextField
		try {
			xUserField = (XDependentTextField) UnoRuntime
					.queryInterface(
							XDependentTextField.class,
							mxDocFactory
									.createInstance("com.sun.star.text.TextField.SetExpression"));
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		XPropertySet xTextPropSet = (XPropertySet) UnoRuntime.queryInterface(
				XPropertySet.class, xUserField);

		try {
			xTextPropSet.setPropertyValue("Content", value);
		} catch (UnknownPropertyException e2) {
			// TODO Auto-generated catch block
			e2.printStackTrace();
		} catch (PropertyVetoException e2) {
			// TODO Auto-generated catch block
			e2.printStackTrace();
		} catch (IllegalArgumentException e2) {
			// TODO Auto-generated catch block
			e2.printStackTrace();
		} catch (WrappedTargetException e2) {
			// TODO Auto-generated catch block
			e2.printStackTrace();
		}

		try {
			xTextPropSet.setPropertyValue("IsVisible", Boolean.FALSE);
		} catch (UnknownPropertyException e2) {
			// TODO Auto-generated catch block
			e2.printStackTrace();
		} catch (PropertyVetoException e2) {
			// TODO Auto-generated catch block
			e2.printStackTrace();
		} catch (IllegalArgumentException e2) {
			// TODO Auto-generated catch block
			e2.printStackTrace();
		} catch (WrappedTargetException e2) {
			// TODO Auto-generated catch block
			e2.printStackTrace();
		}

		// Attach the field master to the user field
		try {
			xUserField.attachTextFieldMaster(xMasterPropSet);
		} catch (IllegalArgumentException e) {
			e.printStackTrace();
		}

		return xUserField;
	}
}
