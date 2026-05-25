package org.openoffice.addon;

import com.sun.star.beans.PropertyValue;
import com.sun.star.frame.DispatchDescriptor;
import com.sun.star.frame.FrameActionEvent;
import com.sun.star.frame.XDispatch;
import com.sun.star.frame.XDispatchProvider;
import com.sun.star.frame.XStatusListener;
import com.sun.star.lang.EventObject;
import com.sun.star.util.URL;

public class Interceptor implements com.sun.star.frame.XFrameActionListener,
		com.sun.star.frame.XDispatchProviderInterceptor,
		com.sun.star.frame.XDispatchProvider, com.sun.star.frame.XDispatch {

	private com.sun.star.frame.XDispatchProvider m_xMaster;

	private com.sun.star.frame.XFrame m_xFrame;

	private com.sun.star.frame.XDispatchProvider m_xSlave;

	private boolean mbInterceptorCalled = false;

	private boolean m_bIsActionListener;

	public Interceptor(com.sun.star.frame.XFrame xFrame) {
		m_xFrame = xFrame;
		m_xSlave = null;
		m_xMaster = null;

		startListening();
	}

	public Interceptor() {
		m_xSlave = null;
		m_xMaster = null;
	}

	public XDispatchProvider getSlaveDispatchProvider() {
		synchronized (this) {
			return m_xSlave;
		}
	}

	public void setSlaveDispatchProvider(XDispatchProvider arg0) {
		synchronized (this) {
			m_xSlave = arg0;
		}
	}

	public XDispatchProvider getMasterDispatchProvider() {
		synchronized (this) {
			return m_xMaster;
		}
	}

	public void setMasterDispatchProvider(XDispatchProvider arg0) {
		synchronized (this) {
			m_xMaster = arg0;
		}
	}

	public XDispatch queryDispatch(URL arg0, String arg1, int arg2) {
		// output for 'known' URLs
		if (arg0.Complete.startsWith("slot:")
				|| arg0.Complete.startsWith(".uno:InsertField")
				|| arg0.Complete.startsWith(".uno:InsertReferenceField")
				|| arg0.Complete.startsWith(".uno:InsertMultiIndex")
				|| arg0.Complete.startsWith(".uno:InsertAuthoritiesEntry")
				|| arg0.Complete.startsWith(".uno:InsertFormula")
				|| arg0.Complete.startsWith(".uno:InsertObjectStarMath")
				|| arg0.Complete.startsWith(".uno:InsertFrame")
				|| arg0.Complete.startsWith(".uno:InsertFootnote")
				|| arg0.Complete.startsWith(".uno:InsertSection"))
		// ||
		// arg0.Complete.startsWith("org.openoffice.addon.ElmlEditor:FuncEdit")
		{
			mbInterceptorCalled = true;
			return null;
		} else {

		}
		// give unknown URLs to slave
		synchronized (this) {
			if (m_xSlave != null) {
				return m_xSlave.queryDispatch(arg0, arg1, arg2);
			}
		}
		return null;
	}

	public XDispatch[] queryDispatches(DispatchDescriptor[] arg0) {
		// Resolve any request seperatly by using own "dispatch()" method.
		int nCount = arg0.length;
		com.sun.star.frame.XDispatch[] lDispatcher = new com.sun.star.frame.XDispatch[nCount];
		for (int i = 0; i < nCount; ++i) {
			lDispatcher[i] = queryDispatch(arg0[i].FeatureURL,
					arg0[i].FrameName, arg0[i].SearchFlags);
		}
		return lDispatcher;
	}

	public void dispatch(URL arg0, PropertyValue[] arg1) {
		// TODO Auto-generated method stub

	}

	public void addStatusListener(XStatusListener arg0, URL arg1) {
		// TODO Auto-generated method stub

	}

	public void removeStatusListener(XStatusListener arg0, URL arg1) {
		// TODO Auto-generated method stub

	}

	public void startListening() {

		com.sun.star.frame.XFrame xFrame = null;
		synchronized (this) {
			if (m_xFrame == null)
				return;
			if (m_bIsActionListener == true)
				return;
			xFrame = m_xFrame;
		}
		m_xFrame.addFrameActionListener(this);
		synchronized (this) {
			m_bIsActionListener = true;
		}

	}

	public void frameAction(FrameActionEvent arg0) {

		switch (arg0.Action.getValue()) {
		case com.sun.star.frame.FrameAction.COMPONENT_ATTACHED_value:

			break;
		case com.sun.star.frame.FrameAction.COMPONENT_DETACHING_value:
			break;
		case com.sun.star.frame.FrameAction.COMPONENT_REATTACHED_value:
			break;
		case com.sun.star.frame.FrameAction.CONTEXT_CHANGED_value:
			break;
		case com.sun.star.frame.FrameAction.FRAME_ACTIVATED_value:
			break;
		case com.sun.star.frame.FrameAction.FRAME_UI_ACTIVATED_value:
			break;
		case com.sun.star.frame.FrameAction.FRAME_UI_DEACTIVATING_value:
			break;
		}

	}

	public void disposing(EventObject arg0) {
		// TODO Auto-generated method stub

	}

}
