module App where

import Node.Globals
import Prelude
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Console (CONSOLE, log)
import Electron
import Electron.App
import Electron.BrowserWindow

main :: forall eff. Eff (console :: CONSOLE, electron :: ELECTRON | eff) Unit
main = do
  appPath <- getAppPath
  log appPath
  homePath <- getPath Home
  log homePath
  onReady do
    log "starting..."
    mainWindow <- newBrowserWindow [ Width 1200
                                   , Height 600
                                   , WebPreferences [ OverlayScrollbars true
                                                    , ZoomFactor 1.0
                                                    ]
                                   ]
    mainWindow `onClose` quit
    mainWindow `loadURL` ("file://" <> __dirname <> "/window.html")
