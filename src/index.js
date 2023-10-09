import express from 'express'
import { GStreamer } from './libraries/g-streamer.js'

const app = express()

app.listen(3000, () => {
  console.log('server started')
})

app.get('/version', (req, res) => {
  try {
    const gStreamerInstance = new GStreamer()
    gStreamerInstance.initiate()
    const gstVersion = gStreamerInstance.getGstVersion()
    res.json({
      // gstVersion,
      status: 'OK'
    })
  } catch(ex) {
    console.error(ex)
    res.json({
      status: 'Error'
    })
  }
  
})