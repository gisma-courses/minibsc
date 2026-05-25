package org.openoffice.addon;

import java.awt.Frame;

import com.sun.star.frame.XFrame;
import com.sun.star.lang.XComponent;
import com.sun.star.view.XSelectionSupplier;

public class FrameInfo {
	private XComponent xComponent;

	private XFrame xFrameName;

	private XSelectionSupplier selectionSupplier;

	private SelectionChangeListener select;
	
	private XmlConverter xXmlConvert;

	public FrameInfo(XComponent xComp, XFrame xActualFrame,
			XSelectionSupplier selSup, SelectionChangeListener selLis, XmlConverter xmlConv) {
		xComponent = xComp;
		xFrameName = xActualFrame;
		selectionSupplier = selSup;
		select = selLis;
		xXmlConvert = xmlConv;
	}

	public XComponent getXComp() {
		return xComponent;
	}

	public XFrame getXFrame() {
		return xFrameName;
	}
	
	public XSelectionSupplier getXSelSupplier() {
		return selectionSupplier;
	}
	
	public SelectionChangeListener getXSelChangeListener() {
		return select;
	}
	
	public XmlConverter getXmlConverter() {
		return xXmlConvert;
	}
}
