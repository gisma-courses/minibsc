package org.openoffice.addon;

import com.sun.star.beans.XPropertySet;
import com.sun.star.ui.ActionTriggerSeparatorType;
import com.sun.star.ui.ContextMenuInterceptorAction;
import com.sun.star.ui.XContextMenuInterceptor;
import com.sun.star.uno.UnoRuntime;

public class ContextMenuInterceptor implements XContextMenuInterceptor {

	public ContextMenuInterceptorAction notifyContextMenuExecute(
			com.sun.star.ui.ContextMenuExecuteEvent aEvent)
			throws RuntimeException {

		try {
			// Retrieve context menu container and query for service factory to
			// create sub menus, menu entries and separators
			com.sun.star.container.XIndexContainer xContextMenu = aEvent.ActionTriggerContainer;
			com.sun.star.lang.XMultiServiceFactory xMenuElementFactory = (com.sun.star.lang.XMultiServiceFactory) UnoRuntime
					.queryInterface(
							com.sun.star.lang.XMultiServiceFactory.class,
							xContextMenu);

			if (xMenuElementFactory != null) {

				// create root menu entry for sub menu and sub menu
				com.sun.star.beans.XPropertySet xRootMenuEntry = (XPropertySet) UnoRuntime
						.queryInterface(
								com.sun.star.beans.XPropertySet.class,
								xMenuElementFactory
										.createInstance("com.sun.star.ui.ActionTrigger"));

				// create a line separator for our new help sub menu
				com.sun.star.beans.XPropertySet xSeparator = (com.sun.star.beans.XPropertySet) UnoRuntime
						.queryInterface(
								com.sun.star.beans.XPropertySet.class,
								xMenuElementFactory
										.createInstance("com.sun.star.ui.ActionTriggerSeparator"));

				Short aSeparatorType = new Short(
						ActionTriggerSeparatorType.LINE);

				xSeparator.setPropertyValue("SeparatorType",
						(Object) aSeparatorType);

				// query sub menu for index container to get access
				com.sun.star.container.XIndexContainer xSubMenuContainer = (com.sun.star.container.XIndexContainer) UnoRuntime
						.queryInterface(
								com.sun.star.container.XIndexContainer.class,
								xMenuElementFactory
										.createInstance("com.sun.star.ui.ActionTriggerContainer"));

				// intialize root menu entry "Help"
				xRootMenuEntry.setPropertyValue("Text",
						new String("eLML Plugin"));
				xRootMenuEntry.setPropertyValue("CommandURL", new String(""));
				xRootMenuEntry.setPropertyValue("SubContainer",
						(Object) xSubMenuContainer);
				// slot:5410
				// create menu entries for the new sub menu
				// intialize help/content menu entry
				// entry "Content"
				XPropertySet xMenuEntry = (XPropertySet) UnoRuntime
						.queryInterface(
								XPropertySet.class,
								xMenuElementFactory
										.createInstance("com.sun.star.ui.ActionTrigger"));

				xMenuEntry.setPropertyValue("Text", new String("Editieren"));
				xMenuEntry.setPropertyValue("CommandURL", new String(
						"org.openoffice.addon.ElmlEditor:FuncEdit"));

				// insert menu entry to sub menu
				xSubMenuContainer.insertByIndex(0, (Object) xMenuEntry);

				// intialize help/help agent
				// entry "Help Agent"
				xMenuEntry = (com.sun.star.beans.XPropertySet) UnoRuntime
						.queryInterface(
								com.sun.star.beans.XPropertySet.class,
								xMenuElementFactory
										.createInstance("com.sun.star.ui.ActionTrigger"));

				xMenuEntry.setPropertyValue("Text", new String("Löschen"));
				xMenuEntry.setPropertyValue("CommandURL", new String(
						"org.openoffice.addon.ElmlEditor:FuncDelete"));

				// insert menu entry to sub menu
				xSubMenuContainer.insertByIndex(1, (Object) xMenuEntry);

				// add separator into the given context menu
				xContextMenu.insertByIndex(0, (Object) xSeparator);

				// add new sub menu into the given context menu
				xContextMenu.insertByIndex(0, (Object) xRootMenuEntry);

				// The controller should execute the modified context menu and
				// stop notifying other
				// interceptors.

				return com.sun.star.ui.ContextMenuInterceptorAction.EXECUTE_MODIFIED;
			}
		}

		catch (com.sun.star.beans.UnknownPropertyException ex) {
			// do something useful
			// we used a unknown property
		}

		catch (com.sun.star.lang.IndexOutOfBoundsException ex) {
			// do something useful
			// we used an invalid index for accessing a container
		}

		catch (com.sun.star.uno.Exception ex) {
			// something strange has happend!
		}

		catch (java.lang.Throwable ex) {
			// catch java exceptions – do something useful
		}

		return com.sun.star.ui.ContextMenuInterceptorAction.IGNORED;

	}
}
