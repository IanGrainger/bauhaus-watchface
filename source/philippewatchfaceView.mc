using Toybox.WatchUi;
using Toybox.Graphics as Gfx;
using Toybox.System as Sys;
using Toybox.Lang;
using Toybox.Time;
using Toybox.Time.Gregorian;

class philippewatchfaceView extends WatchUi.WatchFace {
	var fontPhillipe = null;
	var fontBerlin = null;
    function initialize() {
        WatchFace.initialize();
    }

    // Load your resources here
    function onLayout(dc) {
    	fontPhillipe = WatchUi.loadResource(Rez.Fonts.phillipe96);
    	fontBerlin = WatchUi.loadResource(Rez.Fonts.berlin);
        //setLayout(Rez.Layouts.WatchFace(dc));
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() {
    }

    // Update the view
    function onUpdate(dc) {
    	
    	dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_BLACK);
    	dc.clear();
        // Get and show the current time
        var clockTime = System.getClockTime();
        var hour = clockTime.hour;
        if(!Sys.getDeviceSettings().is24Hour) {
        	hour = hour % 12;
        	if (hour == 0) {
        	hour = 12;
        	}
        }
        var today = Gregorian.info(Time.now(), Time.FORMAT_MEDIUM);
		var dateString = Lang.format(
//		    "$1$:$2$:$3$ $4$ $5$ $6$ $7$",
			"$1$ $2$ $3$",
		    [
//		        today.hour,
//		        today.min,
//		        today.sec,
		        today.day_of_week,
		        today.day,
		        today.month
		        //,
//		        today.year
		    ]
		);
		//Sys.println(dateString); // e.g. "16:28:32 Wed 1 Mar 2017"
		        
        // Forerunner 735xt height 180/width 215
        dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT);
        dc.drawText(dc.getWidth()/2+50, dc.getHeight()/2-80, fontPhillipe, hour.toString(), Gfx.TEXT_JUSTIFY_RIGHT);
        //dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT);
        dc.drawText(dc.getWidth()/2, 15, fontBerlin, dateString, Gfx.TEXT_JUSTIFY_CENTER);
        dc.drawText(dc.getWidth()/2+50, dc.getHeight()/2-10, fontPhillipe, Lang.format("$1$", [clockTime.min.format("%02d")]), Gfx.TEXT_JUSTIFY_RIGHT);
        dc.setColor(Gfx.COLOR_RED, Gfx.COLOR_TRANSPARENT);
        dc.drawText(dc.getWidth()/2, 0, fontBerlin, "ian.grainger@gmail.com", Gfx.TEXT_JUSTIFY_CENTER);
        
//        var timeString = Lang.format("$1$:$2$", [clockTime.hour, clockTime.min.format("%02d")]);
//        var view = View.findDrawableById("TimeLabel");
//        view.setText(timeString);

        // Call the parent onUpdate function to redraw the layout
        //View.onUpdate(dc);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() {
    }

    // The user has just looked at their watch. Timers and animations may be started here.
    function onExitSleep() {
    }

    // Terminate any active timers and prepare for slow updates.
    function onEnterSleep() {
    }

}

//using Toybox.WatchUi;
//using Toybox.Graphics;
//using Toybox.System;
//using Toybox.Lang;
//using Toybox.Application;
//
//class philippewatchfaceView extends WatchUi.WatchFace {
//
//    function initialize() {
//        WatchFace.initialize();
//    }
//
//    // Load your resources here
//    function onLayout(dc) {
//        setLayout(Rez.Layouts.WatchFace(dc));
//    }
//
//    // Called when this View is brought to the foreground. Restore
//    // the state of this View and prepare it to be shown. This includes
//    // loading resources into memory.
//    function onShow() {
//    }
//
//    // Update the view
//    function onUpdate(dc) {
//        // Get the current time and format it correctly
//        var timeFormat = "$1$:$2$";
//        var clockTime = System.getClockTime();
//        var hours = clockTime.hour;
//        if (!System.getDeviceSettings().is24Hour) {
//            if (hours > 12) {
//                hours = hours - 12;
//            }
//        } else {
//            if (Application.getApp().getProperty("UseMilitaryFormat")) {
//                timeFormat = "$1$$2$";
//                hours = hours.format("%02d");
//            }
//        }
//        var timeString = Lang.format(timeFormat, [hours, clockTime.min.format("%02d")]);
//
//        // Update the view
//        var view = View.findDrawableById("TimeLabel");
//        view.setColor(Application.getApp().getProperty("ForegroundColor"));
//        view.setText(timeString);
//
//        // Call the parent onUpdate function to redraw the layout
//        View.onUpdate(dc);
//    }
//
//    // Called when this View is removed from the screen. Save the
//    // state of this View here. This includes freeing resources from
//    // memory.
//    function onHide() {
//    }
//
//    // The user has just looked at their watch. Timers and animations may be started here.
//    function onExitSleep() {
//    }
//
//    // Terminate any active timers and prepare for slow updates.
//    function onEnterSleep() {
//    }
//
//}
