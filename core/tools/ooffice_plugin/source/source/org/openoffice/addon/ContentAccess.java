/*
 * ContentAccess.java
 * 
 * Helper class to access TextContents
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
import com.sun.star.container.XEnumeration;
import com.sun.star.container.XEnumerationAccess;
import com.sun.star.container.XNamed;
import com.sun.star.lang.IllegalArgumentException;
import com.sun.star.lang.WrappedTargetException;
import com.sun.star.lang.XServiceInfo;
import com.sun.star.text.XParagraphCursor;
import com.sun.star.text.XTextRange;
import com.sun.star.text.XTextSection;
import com.sun.star.uno.Any;
import com.sun.star.uno.UnoRuntime;

public class ContentAccess {

	/**
	 * Get the current section from the XParagraphCursor
	 * 
	 * @param xParaCursor
	 *            actual cursor position
	 * @return XTextSection of the actual cursor position
	 */
	public XTextSection getSection(XParagraphCursor xParaCursor) {

		XPropertySet loXPropertySet = (XPropertySet) UnoRuntime.queryInterface(
				XPropertySet.class, xParaCursor);

		XTextSection xTextSection = null;
		try {
			xTextSection = (XTextSection) ((Any) loXPropertySet
					.getPropertyValue("TextSection")).getObject();
		} catch (UnknownPropertyException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (WrappedTargetException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return xTextSection;
	}

	/**
	 * Create an XEnumeration of the content of the section
	 * 
	 * @param xTextSection
	 *            the XTextSection of interest
	 * @return XEnumeration of the content
	 */
	public XEnumeration createInnerSectionEnum(XTextSection xTextSection) {
		XTextRange xSectionRange = xTextSection.getAnchor();

		XEnumerationAccess xSectionAccess = (XEnumerationAccess) UnoRuntime
				.queryInterface(XEnumerationAccess.class, xSectionRange);

		XEnumeration xSectEnum = xSectionAccess.createEnumeration();

		return xSectEnum;
	}

	/**
	 * Get the section name
	 * 
	 * @param xTextSection
	 *            the XTextSection of interest
	 * @return name of the section
	 */
	public String getSectionName(XTextSection xTextSection) {
		String sectionName = null;
		if (xTextSection != null) {
			XNamed sectionNamed = (XNamed) UnoRuntime.queryInterface(
					XNamed.class, xTextSection);
			sectionName = sectionNamed.getName();
		}

		return sectionName;
	}

	/**
	 * Set the section name
	 * 
	 * @param xTextSection
	 *            the XTextSection of interest
	 * @param sectionName
	 *            name for the section
	 */
	public void setSectionName(XTextSection xTextSection, String sectionName) {
		if (xTextSection != null) {
			XNamed sectionNamed = (XNamed) UnoRuntime.queryInterface(
					XNamed.class, xTextSection);
			sectionNamed.setName("");
			sectionNamed.setName(sectionName);
		}
	}

	/**
	 * Get the bookmark object out of a TextPortion
	 * 
	 * @param xPortion
	 *            the TextPortion of interest
	 * @return Bookmark object
	 */
	public Object getBookmark(Object xPortion) throws UnknownPropertyException,
			WrappedTargetException {
		Object xBookmark = null;
		XPropertySet TextProp = (XPropertySet) UnoRuntime.queryInterface(
				XPropertySet.class, xPortion);
		xBookmark = TextProp.getPropertyValue("Bookmark");

		return xBookmark;
	}

	/**
	 * Get the bookmark name out of a Bookmark object
	 * 
	 * @param xBookmark
	 *            the Bookmark of interest
	 * @return name of the Bookmark
	 */
	public String getBookmarkName(Object xBookmark) {
		String bookmarkName = null;
		if (xBookmark != null) {
			XNamed bookmarkNamed = (XNamed) UnoRuntime.queryInterface(
					XNamed.class, xBookmark);
			bookmarkName = bookmarkNamed.getName();
		}

		return bookmarkName;
	}

	/**
	 * Set the bookmark name
	 * 
	 * @param xBookmark
	 *            the Bookmark of interest
	 * @param bookmarkName
	 *            name for the Bookmark
	 */
	public void setBookmarkName(Object xBookmark, String bookmarkName) {
		if (xBookmark != null) {
			XNamed bookmarkNamed = (XNamed) UnoRuntime.queryInterface(
					XNamed.class, xBookmark);

			// TODO: Why does the name has to be set back, otherwise it won't
			// work
			// if String doesn't change
			bookmarkNamed.setName("");
			bookmarkNamed.setName(bookmarkName);
		}
	}

	/**
	 * Create an XEnumeration of the content of the paragraph
	 * 
	 * @param xParagraph
	 *            the Paragraph of interest
	 * @return XEnumeration of the content
	 */
	public XEnumeration createInnerParaEnum(Object xParagraph) {
		XTextRange xParaRange = (XTextRange) UnoRuntime.queryInterface(
				XTextRange.class, xParagraph);

		XEnumerationAccess xParaAccess = (XEnumerationAccess) UnoRuntime
				.queryInterface(XEnumerationAccess.class, xParaRange);

		XEnumeration xParaEnum = xParaAccess.createEnumeration();

		return xParaEnum;
	}

	/**
	 * Get the Text object out of a TextPortion
	 * 
	 * @param xPortion
	 *            the TextPortion of interest
	 * @return Text object
	 */
	public Object getText(Object xPortion) {
		Object Text = xPortion;

		return Text;
	}

	/**
	 * Get the Text out of an xPortion
	 * 
	 * @param xPortion
	 *            the TextPortion of interest
	 * @return text content of the TextPortion
	 */
	public String getStringPortion(Object xPortion) {
		String text = null;
		XTextRange xTextR = (XTextRange) UnoRuntime.queryInterface(
				XTextRange.class, xPortion);
		text = xTextR.getString();

		return text;
	}

	/**
	 * Set the text of the xPortion
	 * 
	 * @param xPortion
	 *            the TextPortion of interest
	 * @param xContent
	 *            the new TextContent
	 */
	public void setStringPortion(Object xPortion, String xContent) {
		if (xPortion != null) {
			XTextRange xTextR = (XTextRange) UnoRuntime.queryInterface(
					XTextRange.class, xPortion);
			xTextR.setString(xContent);
		}
	}

	/**
	 * Get the PortionType of the TextPortion
	 * 
	 * @param xPortion
	 *            the TextPortion of interest
	 * @return PortionType
	 */
	public String getPortionType(Object xPortion)
			throws UnknownPropertyException, WrappedTargetException {
		String portionType = null;
		XPropertySet TextProp = (XPropertySet) UnoRuntime.queryInterface(
				XPropertySet.class, xPortion);

		portionType = (String) TextProp.getPropertyValue("TextPortionType");

		return portionType;
	}

	/**
	 * Get the XServiceInfo of the object
	 * 
	 * @param unknownComp
	 *            the object of interest
	 * @return XServiceInfo of the object
	 */
	public XServiceInfo getServiceInfo(Object unknownComp) {
		XServiceInfo xInfo = (XServiceInfo) UnoRuntime.queryInterface(
				XServiceInfo.class, unknownComp);

		return xInfo;
	}

	/**
	 * Get the TextField object out of a TextPortion
	 * 
	 * @param xPortion
	 *            the TextPortion of interest
	 * @return TextField object
	 */
	public Object getTextField(Object xPortion) {
		Object xTextField = null;
		XPropertySet TextProp = (XPropertySet) UnoRuntime.queryInterface(
				XPropertySet.class, xPortion);
		try {
			xTextField = TextProp.getPropertyValue("TextField");
		} catch (UnknownPropertyException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (WrappedTargetException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return xTextField;
	}

	/**
	 * Get the TextField name out of a DependentTextField object
	 * 
	 * @param xTextField
	 *            the TextField of interest
	 * @return name of the TextField
	 */
	public String getTextFieldName(Object xTextField) {
		String textFieldName = null;
		if (xTextField != null) {
			XPropertySet xTextPropSet = (XPropertySet) UnoRuntime
					.queryInterface(XPropertySet.class, xTextField);
			try {
				textFieldName = (String) xTextPropSet
						.getPropertyValue("Content");
			} catch (UnknownPropertyException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (WrappedTargetException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}

		return textFieldName;
	}

	/**
	 * Set the TextField name
	 * 
	 * @param xTextField
	 *            the TextField of interest
	 * @param value
	 *            name for the TextField
	 */
	public void setTextFieldName(Object xTextField, String value) {
		if (xTextField != null) {
			XPropertySet xTextPropSet = (XPropertySet) UnoRuntime
					.queryInterface(XPropertySet.class, xTextField);
			try {
				xTextPropSet.setPropertyValue("Content", value);
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
	}

}
