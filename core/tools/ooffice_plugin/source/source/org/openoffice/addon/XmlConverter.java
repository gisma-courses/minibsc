package org.openoffice.addon;

import java.awt.Frame;

import com.sun.star.awt.XControl;
import com.sun.star.awt.XControlContainer;
import com.sun.star.awt.XControlModel;
import com.sun.star.awt.XDialog;
import com.sun.star.awt.XWindow;
import com.sun.star.beans.PropertyValue;
import com.sun.star.container.XNameContainer;
import com.sun.star.frame.XStorable;
import com.sun.star.lang.XComponent;
import com.sun.star.lang.XMultiComponentFactory;
import com.sun.star.lang.XMultiServiceFactory;
import com.sun.star.text.XTextDocument;
import com.sun.star.uno.Exception;
import com.sun.star.uno.UnoRuntime;
import com.sun.star.uno.XComponentContext;

public class XmlConverter {

	private XComponent xComponent;

	private XTextDocument xTextDocument;

	private XStorable storable;

	private XMultiServiceFactory xMSF;

	private DialogController xDialogController;

	private XComponentContext xComponentContext;

	private Object dialogModel;

	private XMultiComponentFactory xMCF;

	private XNameContainer xNameCont;

	private Object dialog;

	private XControlContainer xControlCont;

	private XControl xControl;

	private XControlModel xControlModel;

	private XWindow xWindow;

	private XDialog xDialog;

	private boolean centerWindow = true;
	
	private String fileName = "";

	
	public XmlConverter(XComponent Component) {
		xComponent = Component;
	}
	
	public void exportFile() {
		xDialogController = new DialogController(this);
		try {
			initFilePicker();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public void export() {

		String textContent = xDialogController.getControlText("title");
		fileName = textContent;
		textContent = textContent.replace('\\', '/');
		String xmlOutName = textContent;

		if (!xmlOutName.equals("")) {
			
			xTextDocument = (XTextDocument) UnoRuntime.queryInterface(
					XTextDocument.class, xComponent);

			storable = (XStorable) UnoRuntime.queryInterface(XStorable.class,
					xTextDocument);
			
			PropertyValue properties[] = new PropertyValue[2];
			properties[0] = new PropertyValue();
			properties[0].Name = new String("Overwrite");
			properties[0].Value = Boolean.TRUE;
			properties[1] = new PropertyValue();
			properties[1].Name = new String("FilterName");
			properties[1].Value = new String("eLML");

			try {
				storable.storeToURL("file:///" + xmlOutName, properties);
			} catch (com.sun.star.io.IOException ex) {
				ex.printStackTrace();
			}
		}

	}

	private void initFilePicker() throws Exception {
		try {
			xDialogController.setWindowProperties("Export eLML XML", 100, 100,
					170, 80);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		/* ---- LABELS ---- */
		Object title = xDialogController.createLabel("titleLabel",
				"Export nach:", 10, 10, 150, 14, (short) 0, false);
		xDialogController.addElement("titleLabel", title);

		/* ---- TEXTFIELDS ---- */
		Object titleTxt = xDialogController.createFileControl("title", fileName, 10,
				25, 150, 14, (short) 1);
		xDialogController.addElement("title", titleTxt);

		/* ---- BUTTONS ---- */
		Object buttonOK = xDialogController.createButton("export", "Exportieren", 110,
				55, 50, 14, (short) 4);
		xDialogController.addElement("export", buttonOK);
		xDialogController.attachActionListener("export");

		Object buttonCancel = xDialogController.createButton("cancel",
				"Abbrechen", 55, 55, 50, 14, (short) 5);
		xDialogController.addElement("cancel", buttonCancel);
		xDialogController.attachActionListener("cancel");

		xDialogController.showDialog();
	}

	/*
	private void exportGraphics() {

		xMSF = (XMultiServiceFactory) UnoRuntime.queryInterface(
				XMultiServiceFactory.class, ElementController.getXMCF());

		XGraphicProvider xGraphicProvider = null;
		try {
			xGraphicProvider = (XGraphicProvider) UnoRuntime
					.queryInterface(
							XGraphicProvider.class,
							xMSF
									.createInstance("com.sun.star.graphic.GraphicProvider"));
		} catch (Exception e2) {
			// TODO Auto-generated catch block
			e2.printStackTrace();
		}

		Object oUnoObject = null;
		try {
			oUnoObject = (xMSF
					.createInstance("com.sun.star.drawing.GraphicExportFilter"));
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		Object oGraphic = null;

		XTextGraphicObjectsSupplier xGraphicSupplier = (XTextGraphicObjectsSupplier) UnoRuntime
				.queryInterface(XTextGraphicObjectsSupplier.class,
						xTextDocument);

		XNameAccess xNamedGraphics = xGraphicSupplier.getGraphicObjects();

		XIndexAccess xIndexedGraphics = (XIndexAccess) UnoRuntime
				.queryInterface(XIndexAccess.class, xNamedGraphics);

		try {
			oGraphic = xIndexedGraphics.getByIndex(0);


		} catch (IndexOutOfBoundsException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		} catch (WrappedTargetException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}

		XShape xShape = (XShape) UnoRuntime.queryInterface(XShape.class,
				oGraphic);

		// now query the necessary interfaces from the object:

		XExporter xExporter = (XExporter) UnoRuntime.queryInterface(
				XExporter.class, oUnoObject);

		XFilter xfilter = (XFilter) UnoRuntime.queryInterface(XFilter.class,
				oUnoObject);

		XComponent xComp = (XComponent) UnoRuntime.queryInterface(
				XComponent.class, xShape);

		try {

			xExporter.setSourceDocument(xComp);
		} catch (IllegalArgumentException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		com.sun.star.beans.PropertyValue[] xGraphProps1 = new com.sun.star.beans.PropertyValue[3];
		xGraphProps1[1] = new PropertyValue();
		xGraphProps1[1].Name = "URL";
		xGraphProps1[1].Value = "file:///c:/Work/Mels/test.jpg";
		xGraphProps1[2] = new PropertyValue();
		xGraphProps1[2].Name = "MediaType";
		xGraphProps1[2].Value = "image/jpeg";

		boolean test = xfilter.filter(xGraphProps1);

		new MsgBox(new Frame(""), "Ergebnis: " + test, false);

	}
	*/

}
