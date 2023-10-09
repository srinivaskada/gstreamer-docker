import gi from 'node-gtk'
export class GStreamer {
  static gLoopStarted = false
  constructor() {}

  initiate() {
    const GLib = gi.require('GLib', '2.0')
    const Gst = gi.require('Gst', '1.0')
    if(!GStreamer.gLoopStarted) {
      GStreamer.gLoopStarted = true
      gi.startLoop()
      Gst.init()
    }
  }

  getGstVersion() {
    // return Gst.version()
  }
}
