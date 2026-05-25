/**
 * eLML Editor Starter Class
 * 
 */

package org.openoffice.addon;

import java.awt.Frame;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.Set;
import java.util.Vector;

import com.sun.star.beans.PropertyValue;
import com.sun.star.beans.PropertyVetoException;
import com.sun.star.beans.UnknownPropertyException;
import com.sun.star.beans.XPropertySet;
import com.sun.star.comp.loader.FactoryHelper;
import com.sun.star.frame.DispatchDescriptor;
import com.sun.star.frame.FeatureStateEvent;
import com.sun.star.frame.XComponentLoader;
import com.sun.star.frame.XController;
import com.sun.star.frame.XDesktop;
import com.sun.star.frame.XDispatch;
import com.sun.star.frame.XDispatchProvider;
import com.sun.star.frame.XFrame;
import com.sun.star.frame.XModel;
import com.sun.star.frame.XStatusListener;
import com.sun.star.lang.IllegalArgumentException;
import com.sun.star.lang.WrappedTargetException;
import com.sun.star.lang.XComponent;
import com.sun.star.lang.XInitialization;
import com.sun.star.lang.XMultiComponentFactory;
import com.sun.star.lang.XMultiServiceFactory;
import com.sun.star.lang.XServiceInfo;
import com.sun.star.lang.XSingleServiceFactory;
import com.sun.star.lib.uno.helper.WeakBase;
import com.sun.star.registry.XRegistryKey;
import com.sun.star.task.XAsyncJob;
import com.sun.star.text.XText;
import com.sun.star.text.XTextDocument;
import com.sun.star.uno.Exception;
import com.sun.star.uno.UnoRuntime;
import com.sun.star.uno.XComponentContext;
import com.sun.star.util.URL;
import com.sun.star.util.XURLTransformer;
import com.sun.star.view.XSelectionSupplier;
import com.sun.star.view.XViewSettingsSupplier;

public class ElmlEditor extends WeakBase implements XDispatchProvider,
		XDispatch, XServiceInfo, XAsyncJob, XInitialization {

	public static XComponentContext xComponentContext = null;

	private XComponent xComponent;

	public XMultiComponentFactory xMCF;

	private XDesktop xDesktop;

	private Object desktop;

	private String ParaName;

	private XComponentLoader xCLoader;

	private XTextDocument xTextDocument;

	private XModel xModel;

	private XController xController;

	public static XMultiServiceFactory mxDocFactory;

	public static HashMap registeredDispatchers = new HashMap();

	private XFrame xFrameObject;

	private SelectionChangeListener xSelect;

	private XmlConverter convertElml;

	private XPropertySet ViewSettings;

	public static XSelectionSupplier xSelectionSupplier;

	public static HashMap registeredListeners = new HashMap();

	public static HashSet frames;

	protected static final String __serviceName = "org.openoffice.addon.ElmlEditor";

	/**
	 * Initiate OpenOffice Environment
	 */
	public ElmlEditor(XComponentContext xCompContext) {

		xComponentContext = xCompContext;

		try {
			xMCF = xComponentContext.getServiceManager();

			desktop = xMCF.createInstanceWithContext(
					"com.sun.star.frame.Desktop", xComponentContext);

			xDesktop = (XDesktop) UnoRuntime.queryInterface(XDesktop.class,
					desktop);

			xCLoader = (XComponentLoader) UnoRuntime.queryInterface(
					XComponentLoader.class, desktop);

		} catch (java.lang.Exception e) {
			e.printStackTrace(System.err);
		}

	}

	/**
	 * Open a new file with root dialog
	 * 
	 * @throws Exception
	 */
	public void newFile() {
		xComponent = newComponent();

		xTextDocument = (XTextDocument) UnoRuntime.queryInterface(
				XTextDocument.class, xComponent);

		mxDocFactory = (XMultiServiceFactory) UnoRuntime.queryInterface(
				XMultiServiceFactory.class, xTextDocument);

		ElementController.createContext(xMCF, xComponent);
		ElementController.createElement("ElmlLesson");

		// xModel = (XModel) UnoRuntime.queryInterface(XModel.class,
		// xComponent);
		// xController = xModel.getCurrentController();
	}

	/**
	 * Open a new element dialog
	 * 
	 */
	public void newElement(String elementName) {
		// xComponent = xDesktop.getCurrentComponent();
		xComponent = ElementController.getXComponent();
		ElementController.createContext(xMCF, xComponent);
		ElementController.createElement(elementName);
	}

	/**
	 * Delete an element and all of its content
	 * 
	 * @param buttonName
	 * 
	 */
	private void deleteElement() {
		ContentContext xContentContext = new ContentContext();
		// xComponent = xDesktop.getCurrentComponent();
		xComponent = ElementController.getXComponent();
		ParaName = xContentContext.getContext(xComponent);
		ElementController.createContext(xMCF, xComponent);
		ElementController.deleteElement(ParaName);
	}

	/**
	 * Open a new edit dialog
	 * 
	 * @throws Exception
	 */
	private void editElement() throws Exception {
		ParaName = "";
		ContentContext xContentContext = new ContentContext();
		// xComponent = xDesktop.getCurrentComponent();
		xComponent = ElementController.getXComponent();
		ParaName = xContentContext.getContext(xComponent);
		ElementController.createContext(xMCF, xComponent);
		ElementController.editElement(ParaName);
	}

	/**
	 * Load a new component
	 */
	private XComponent newComponent() {
		try {
			// gather arguments for new component
			PropertyValue[] szEmptyArgs = new PropertyValue[0];
			String strDoc = "private:factory/swriter";

			// create new component
			xComponent = xCLoader.loadComponentFromURL(strDoc, "_default", 0,
					szEmptyArgs);

		} catch (Exception e) {
			System.err.println(" Exception " + e);
			e.printStackTrace(System.err);
		}
		return xComponent;
	}

	public XComponent getComponent() {
		return xDesktop.getCurrentComponent();
	}

	public void initialize(Object[] object) throws com.sun.star.uno.Exception {
		// object[0] = actual frame
	}

	public String getImplementationName() {
		return ElmlEditor.class.getName();
	}

	public boolean supportsService(String serviceName) {
		return serviceName.equals(__serviceName);
	}

	public String[] getSupportedServiceNames() {
		return getServiceNames();
	}

	public static String[] getServiceNames() {
		String[] sSupportedServiceNames = { __serviceName };
		return sSupportedServiceNames;
	}

	public static XSingleServiceFactory __getServiceFactory(String implName,
			XMultiServiceFactory multiFactory,
			com.sun.star.registry.XRegistryKey regKey) {

		com.sun.star.lang.XSingleServiceFactory xSingleServiceFactory = null;
		if (implName.equals(ElmlEditor.class.getName()))
			xSingleServiceFactory = FactoryHelper.getServiceFactory(
					ElmlEditor.class, ElmlEditor.__serviceName, multiFactory,
					regKey);

		return xSingleServiceFactory;
	}

	public static boolean __writeRegistryServiceInfo(XRegistryKey regKey) {
		return FactoryHelper.writeRegistryServiceInfo(ElmlEditor.class
				.getName(), ElmlEditor.getServiceNames(), regKey);
	}

	public XDispatch queryDispatch(URL arg0, String arg1, int arg2) {

		XDispatch xRet = null;
		if (arg0.Protocol.compareTo("org.openoffice.addon.ElmlEditor:") == 0) {
			if (arg0.Path.compareTo("ElmlLesson") == 0) {

				if (registeredDispatchers.containsKey("ElmlLesson")) {
					xRet = (XDispatch) registeredDispatchers.get("ElmlLesson");
				} else {
					String url = arg0.Path;
					registeredDispatchers.put(url, this);
					xRet = this;
				}
				xRet = this;
			}
			if (arg0.Path.compareTo("ElmlUnit") == 0) {

				if (registeredDispatchers.containsKey("ElmlUnit")) {
					xRet = (XDispatch) registeredDispatchers.get("ElmlUnit");
				} else {
					String url = arg0.Path;
					registeredDispatchers.put(url, this);
					xRet = this;
				}
				xRet = this;
			}
			if (arg0.Path.compareTo("ElmlLearningObject") == 0) {

				if (registeredDispatchers.containsKey("ElmlLearningObject")) {
					xRet = (XDispatch) registeredDispatchers
							.get("ElmlLearningObject");
				} else {
					String url = arg0.Path;
					registeredDispatchers.put(url, this);
					xRet = this;
				}
				xRet = this;
			}
			if (arg0.Path.compareTo("ElmlClarify") == 0) {

				if (registeredDispatchers.containsKey("ElmlClarify")) {
					xRet = (XDispatch) registeredDispatchers.get("ElmlClarify");
				} else {
					String url = arg0.Path;
					registeredDispatchers.put(url, this);
					xRet = this;
				}
				xRet = this;
			}
			if (arg0.Path.compareTo("ElmlLook") == 0) {

				if (registeredDispatchers.containsKey("ElmlLook")) {
					xRet = (XDispatch) registeredDispatchers.get("ElmlLook");
				} else {
					String url = arg0.Path;
					registeredDispatchers.put(url, this);
					xRet = this;
				}
				xRet = this;
			}
			if (arg0.Path.compareTo("ElmlAct") == 0) {

				if (registeredDispatchers.containsKey("ElmlAct")) {
					xRet = (XDispatch) registeredDispatchers.get("ElmlAct");
				} else {
					String url = arg0.Path;
					registeredDispatchers.put(url, this);
					xRet = this;
				}
				xRet = this;
			}
			if (arg0.Path.compareTo("ElmlSummary") == 0) {

				if (registeredDispatchers.containsKey("ElmlSummary")) {
					xRet = (XDispatch) registeredDispatchers.get("ElmlSummary");
				} else {
					String url = arg0.Path;
					registeredDispatchers.put(url, this);
					xRet = this;
				}
				xRet = this;
			}
			if (arg0.Path.compareTo("ContentTerm") == 0) {

				if (registeredDispatchers.containsKey("ContentTerm")) {
					xRet = (XDispatch) registeredDispatchers.get("ContentTerm");
				} else {
					String url = arg0.Path;
					registeredDispatchers.put(url, this);
					xRet = this;
				}
				xRet = this;
			}
			if (arg0.Path.compareTo("ContentCitation") == 0) {

				if (registeredDispatchers.containsKey("ContentCitation")) {
					xRet = (XDispatch) registeredDispatchers
							.get("ContentCitation");
				} else {
					String url = arg0.Path;
					registeredDispatchers.put(url, this);
					xRet = this;
				}
				xRet = this;
			}
			if (arg0.Path.compareTo("ElmlBox") == 0) {

				if (registeredDispatchers.containsKey("ElmlBox")) {
					xRet = (XDispatch) registeredDispatchers.get("ElmlBox");
				} else {
					String url = arg0.Path;
					registeredDispatchers.put(url, this);
					xRet = this;
				}
				xRet = this;
			}
			if (arg0.Path.compareTo("ElmlBibEntry") == 0) {

				if (registeredDispatchers.containsKey("ElmlBibEntry")) {
					xRet = (XDispatch) registeredDispatchers
							.get("ElmlBibEntry");
				} else {
					String url = arg0.Path;
					registeredDispatchers.put(url, this);
					xRet = this;
				}
				xRet = this;
			}
			if (arg0.Path.compareTo("FuncEdit") == 0) {

				if (registeredDispatchers.containsKey("FuncEdit")) {
					xRet = (XDispatch) registeredDispatchers.get("FuncEdit");
				} else {
					String url = arg0.Path;
					registeredDispatchers.put(url, this);
					xRet = this;
				}
				xRet = this;
			}
			if (arg0.Path.compareTo("FuncDelete") == 0) {

				if (registeredDispatchers.containsKey("FuncDelete")) {
					xRet = (XDispatch) registeredDispatchers.get("FuncDelete");
				} else {
					String url = arg0.Path;
					registeredDispatchers.put(url, this);
					xRet = this;
				}
				xRet = this;
			}
			if (arg0.Path.compareTo("FuncExport") == 0) {

				if (registeredDispatchers.containsKey("FuncExport")) {
					xRet = (XDispatch) registeredDispatchers.get("FuncExport");
				} else {
					String url = arg0.Path;
					registeredDispatchers.put(url, this);
					xRet = this;
				}
				xRet = this;
			}
		}

		return xRet;
	}

	public XDispatch[] queryDispatches(DispatchDescriptor[] arg0) {
		int nCount = arg0.length;
		com.sun.star.frame.XDispatch[] lDispatcher = new com.sun.star.frame.XDispatch[nCount];
		for (int i = 0; i < nCount; ++i) {
			lDispatcher[i] = queryDispatch(arg0[i].FeatureURL,
					arg0[i].FrameName, arg0[i].SearchFlags);
		}
		return lDispatcher;
	}

	public void dispatch(URL arg0, PropertyValue[] arg1) {
		if (arg0.Protocol.compareTo("org.openoffice.addon.ElmlEditor:") == 0) {
			if (arg0.Path.compareTo("ElmlLesson") == 0) {
				if (isEmpty()) {
					newElement("ElmlLesson");
				} else {

				}

				/*
				 * try { newFile(); } catch (java.lang.Exception e) {
				 * e.printStackTrace(); }
				 */
			}
			if (arg0.Path.compareTo("ElmlUnit") == 0) {
				newElement("ElmlUnit");
			}
			if (arg0.Path.compareTo("ElmlLearningObject") == 0) {
				newElement("ElmlLearningObject");
			}
			if (arg0.Path.compareTo("ElmlClarify") == 0) {
				newElement("ElmlClarify");
			}
			if (arg0.Path.compareTo("ElmlLook") == 0) {
				newElement("ElmlLook");
			}
			if (arg0.Path.compareTo("ElmlAct") == 0) {
				newElement("ElmlAct");
			}
			if (arg0.Path.compareTo("ElmlSummary") == 0) {
				newElement("ElmlSummary");
			}
			if (arg0.Path.compareTo("ElmlBibEntry") == 0) {
				newElement("ElmlBibEntry");
			}
			if (arg0.Path.compareTo("ContentTerm") == 0) {
				newElement("ContentTerm");
			}
			if (arg0.Path.compareTo("ContentCitation") == 0) {
				newElement("ContentCitation");
			}
			if (arg0.Path.compareTo("ElmlBox") == 0) {
				newElement("ElmlBox");
			}
			if (arg0.Path.compareTo("FuncEdit") == 0) {
				try {
					editElement();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			if (arg0.Path.compareTo("FuncDelete") == 0) {
				MsgBox confirmBox = new MsgBox(new Frame("Löschen"),
						"Wirklich löschen?", true);
				if (confirmBox.id) {
					try {
						deleteElement();
					} catch (java.lang.Exception e) {
						e.printStackTrace();
					}
				}
			}
			if (arg0.Path.compareTo("FuncExport") == 0) {
				try {
					Iterator iterOn = frames.iterator();
					while (iterOn.hasNext()) {
						FrameInfo actFrameInfo = (FrameInfo) iterOn.next();
						if (actFrameInfo.getXComp() == ElementController
								.getXComponent()) {
							convertElml = actFrameInfo.getXmlConverter();
							break;
						}
					}
					/*
					String[] filterNames = { "eLML" };
					String defaultName = "test";
					String defaultDir = "file:///";

					PropertyValue[] propertyvalue = new PropertyValue [4];
					propertyvalue[0] = new PropertyValue();
			        propertyvalue[0].Value = xTextDocument;
			        propertyvalue[1] = new PropertyValue();
			        propertyvalue[1].Value = filterNames;
			        propertyvalue[2] = new PropertyValue();
			        propertyvalue[2].Value = defaultName;
			        propertyvalue[3] = new PropertyValue();
			        propertyvalue[3].Value = defaultDir;

			        com.sun.star.util.URL[] URL = new com.sun.star.util.URL[1];
		            URL[0] = new URL();
		            URL[0].Complete = "vnd.sun.star.script:Tools.ModuleControls.StoreDocument?language=Basic&location=application";

		            XURLTransformer xParser =
			        	(XURLTransformer)UnoRuntime.queryInterface(XURLTransformer.class,
			        			xMCF.createInstanceWithContext("com.sun.star.util.URLTransformer", xComponentContext));
		            xParser.parseStrict(URL);
		            
		            URL aURL = URL[0];

		            dispatch(aURL, propertyvalue);
			        */
					convertElml.exportFile();
				} catch (java.lang.Exception e) {
					e.printStackTrace();
				}
			}
		} else {
			new MsgBox(new Frame(""), "dispatch", false);
		}
	}

	private boolean isEmpty() {
		xComponent = ElementController.getXComponent();
		xTextDocument = (XTextDocument) UnoRuntime.queryInterface(
				XTextDocument.class, xComponent);
		XText xText = xTextDocument.getText();

		if (xText.getString().equals("")) {
			return true;
		} else {
			MsgBox confirm = new MsgBox(new Frame(""),
					"Der gesamte Inhalte wird gelöscht. Wirklich fortfahren?",
					true);
			if (confirm.id) {
				return true;
			}
		}
		return false;
	}

	public void addStatusListener(XStatusListener arg0, URL arg1) {
		String url = arg1.Path;
		registeredListeners.put(url, arg0);

		FeatureStateEvent aState = new FeatureStateEvent();
		aState.FeatureURL = arg1;
		aState.IsEnabled = true;
		aState.State = Boolean.FALSE;
		arg0.statusChanged(aState);

	}

	public void removeStatusListener(XStatusListener arg0, URL arg1) {
		registeredListeners.remove(arg1);
	}

	/**
	 * starts execution of this job.
	 * 
	 * @param lArgs
	 *            list which contains:
	 *            <ul>
	 *            <li>generic job configuration data</li>
	 *            <li>job specific configuration data</li>
	 *            <li>some environment informations</li>
	 *            <li>may optional arguments of a corresponding dispatch
	 *            request</li>
	 *            </ul>
	 * 
	 * @params xListener callback to the executor of this job, which control our
	 *         life time
	 * 
	 * @throws com.sun.star.lang.IllegalArgumentException
	 *             if given argument list seams to be wrong
	 */
	public synchronized void executeAsync(
			com.sun.star.beans.NamedValue[] lArgs,
			com.sun.star.task.XJobListener xListener)
			throws com.sun.star.lang.IllegalArgumentException {

		// For asynchronous jobs a valid listener reference is guranteed normaly
		// ...
		if (xListener == null)
			throw new com.sun.star.lang.IllegalArgumentException(
					"invalid listener");

		// extract all possible sub list of given argument list
		com.sun.star.beans.NamedValue[] lGenericConfig = null;
		com.sun.star.beans.NamedValue[] lJobConfig = null;
		com.sun.star.beans.NamedValue[] lEnvironment = null;
		com.sun.star.beans.NamedValue[] lDynamicData = null;

		int c = lArgs.length;

		for (int i = 0; i < c; ++i) {
			if (lArgs[i].Name.equals("Config"))
				lGenericConfig = (com.sun.star.beans.NamedValue[]) com.sun.star.uno.AnyConverter
						.toArray(lArgs[i].Value);
			else if (lArgs[i].Name.equals("JobConfig"))
				lJobConfig = (com.sun.star.beans.NamedValue[]) com.sun.star.uno.AnyConverter
						.toArray(lArgs[i].Value);
			else if (lArgs[i].Name.equals("Environment"))
				lEnvironment = (com.sun.star.beans.NamedValue[]) com.sun.star.uno.AnyConverter
						.toArray(lArgs[i].Value);
			else if (lArgs[i].Name.equals("DynamicData"))
				lDynamicData = (com.sun.star.beans.NamedValue[]) com.sun.star.uno.AnyConverter
						.toArray(lArgs[i].Value);
		}

		// Analyze the environment info. This sub list is the only guarenteed
		// one!
		if (lEnvironment == null)
			throw new com.sun.star.lang.IllegalArgumentException(
					"no environment");

		java.lang.String sEnvType = null;
		java.lang.String sEventName = null;
		c = lEnvironment.length;

		for (int i = 0; i < c; ++i) {
			if (lEnvironment[i].Name.equals("EnvType"))
				sEnvType = com.sun.star.uno.AnyConverter
						.toString(lEnvironment[i].Value);
			else if (lEnvironment[i].Name.equals("EventName"))
				sEventName = com.sun.star.uno.AnyConverter
						.toString(lEnvironment[i].Value);
			else if (lEnvironment[i].Name.equals("Model"))
				xModel = (com.sun.star.frame.XModel) com.sun.star.uno.AnyConverter
						.toObject(new com.sun.star.uno.Type(
								com.sun.star.frame.XModel.class),
								lEnvironment[i].Value);

		}

		// Further the environment property "EnvType" is required as minimum.
		if ((sEnvType == null)
				|| ((!sEnvType.equals("EXECUTOR"))
						&& (!sEnvType.equals("DISPATCH")) && (!sEnvType
						.equals("DOCUMENTEVENT")))) {
			throw new com.sun.star.lang.IllegalArgumentException(
					"no valid value for EnvType");
		}

		xController = xModel.getCurrentController();

		// TODO: REMOVE COMMENT IF WORKING
		// xComponent = xModel;

		xComponent = (XComponent) UnoRuntime.queryInterface(XComponent.class,
				xModel);

		convertElml = new XmlConverter(xComponent);

		// TODO: REMOVE COMMENT IF WORKING
		/*
		 * if (frames == null) { new MsgBox(new Frame(""), "take xModel" ,
		 * false); xComponent = xModel; } else { xComponent =
		 * xDesktop.getCurrentComponent(); }
		 */

		ElementController.createContext(xMCF, xComponent);

		// Initialize Styles
		xTextDocument = (XTextDocument) UnoRuntime.queryInterface(
				XTextDocument.class, xComponent);
		new StylesInit(xTextDocument);

		// TODO: REMOVE COMMENT IF WORKING
		// Add FrameListener to frame
		// xFrameObject = xDesktop.getCurrentFrame();
		xFrameObject = xController.getFrame();
		FrameListener xFrameListener = new FrameListener(xMCF);
		xFrameObject.addFrameActionListener(xFrameListener);

		// Context Menu Interception
		com.sun.star.ui.XContextMenuInterception xContext = (com.sun.star.ui.XContextMenuInterception) UnoRuntime
				.queryInterface(com.sun.star.ui.XContextMenuInterception.class,
						xController);
		xContext.registerContextMenuInterceptor(new ContextMenuInterceptor());

		// Selection Supplier that initiates the SelectionChangeListener
		xSelectionSupplier = (XSelectionSupplier) UnoRuntime.queryInterface(
				XSelectionSupplier.class, xController);
		xSelect = new SelectionChangeListener();
		// xSelectionSupplier.addSelectionChangeListener(xSelect);

		// ViewSetting Supplier to set the view properties
		XViewSettingsSupplier oVSSupp = (XViewSettingsSupplier) UnoRuntime
				.queryInterface(XViewSettingsSupplier.class, xController);
		ViewSettings = oVSSupp.getViewSettings();
		try {
			ViewSettings.setPropertyValue("ShowIndexMarkBackground",
					Boolean.FALSE);
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

		/*
		 * // Dispatch Interception: disable forbidden commands
		 * com.sun.star.frame.XDispatchProviderInterception xRegistration =
		 * (com.sun.star.frame.XDispatchProviderInterception) UnoRuntime
		 * .queryInterface(
		 * com.sun.star.frame.XDispatchProviderInterception.class,
		 * xDesktop.getCurrentFrame());
		 * xRegistration.registerDispatchProviderInterceptor(new Interceptor(
		 * xDesktop.getCurrentFrame()));
		 */

		// Dispatch Interception: disable forbidden commands
		com.sun.star.frame.XDispatchProviderInterception xRegistration = (com.sun.star.frame.XDispatchProviderInterception) UnoRuntime
				.queryInterface(
						com.sun.star.frame.XDispatchProviderInterception.class,
						xController.getFrame());
		xRegistration.registerDispatchProviderInterceptor(new Interceptor(
				xController.getFrame()));

		if (frames == null) {
			frames = new HashSet();
		}

		// Create new FrameInfo object to store everything belonging to frame
		FrameInfo newFrame = new FrameInfo(xComponent, xFrameObject,
				xSelectionSupplier, xSelect, convertElml);
		frames.add(newFrame);

		xListener.jobFinished(this, "");
	}

}
