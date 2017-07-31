# Event Slide

Displays a title slide for an event selected by the venue technical staff based on the unique *event_id*

### Included in Walk-In

The event slide can be part of a walk-in/out playlist using the [Walk-in package](https://github.com/edbookfest/walkin-display) In this mode you should deploy the Walk-In package to info-beamer.com first and add the Event Slide as a child node to be included in the playlist as required. The walk-in node has a capability to render the event slide on demand to provide the static 'event slide' during an event. For more details see the [Walk-in package](https://github.com/edbookfest/walkin-display)

### Stand-alone Mode

The event slide node can be used standalone to display different title slides on command. You can deploy content to it using the "Additional Images" section of the package configuraiton. Use the install button below to add the package in stand-alone mode

[![Import](https://cdn.infobeamer.com/s/img/import.png)](https://info-beamer.com/use?url=https://github.com/edbookfest/event-slide-display.git)

## Image Specification

 - For best quality images should be same resolution as output display (1920 x 1080 ideally)
 - PNG format
 - Named `<event_id>.png`
 

## Control

The package accepts the following commands sent via UDP to port 4444:

Load and display the event slide for `<event_id>` 
```walkin/event-slide/eventid:<event_id>```
