package org.openoffice.addon;

import java.awt.Frame;
import java.util.Iterator;

import com.sun.star.frame.FrameActionEvent;
import com.sun.star.frame.XFrame;
import com.sun.star.lang.EventObject;
import com.sun.star.lang.XMultiComponentFactory;

public class FrameListener implements com.sun.star.frame.XFrameActionListener {

	private XFrame actualFrame;
	private static XMultiComponentFactory xMCF;
	private FrameInfo fInfo;
	
	public FrameListener(XMultiComponentFactory mcf) {
		xMCF = mcf;
	}

	public void frameAction(FrameActionEvent arg0) {
		switch (arg0.Action.getValue()) {
		case com.sun.star.frame.FrameAction.CONTEXT_CHANGED_value:
			break;
		case com.sun.star.frame.FrameAction.FRAME_ACTIVATED_value:

			Iterator iterOn = ElmlEditor.frames.iterator();
			while (iterOn.hasNext()) {
				FrameInfo actFrameInfo = (FrameInfo) iterOn.next();

				if (actFrameInfo.getXFrame() == arg0.Frame) {
					fInfo = actFrameInfo;
					break;
				}
			}
			//fInfo.getXSelSupplier().addSelectionChangeListener(fInfo.getXSelChangeListener());
			arg0.Frame.addFrameActionListener(this);
			ElementController.createContext(xMCF, fInfo.getXComp());
			break;
		case com.sun.star.frame.FrameAction.FRAME_DEACTIVATING_value:
			Iterator iterOff = ElmlEditor.frames.iterator();
			while (iterOff.hasNext()) {
				FrameInfo actFrameInfo = (FrameInfo) iterOff.next();
				if (actFrameInfo.getXFrame() == arg0.Frame) {
					fInfo = actFrameInfo;
					break;
				}
			}
			// remove selectionListener and frameListener
			//fInfo.getXSelSupplier().removeSelectionChangeListener(fInfo.getXSelChangeListener());
			break;
		}
	}

	public void disposing(EventObject arg0) {
		// TODO Auto-generated method stub
	}

}
