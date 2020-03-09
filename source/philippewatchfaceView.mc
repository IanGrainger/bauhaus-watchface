using Toybox.WatchUi;
using Toybox.Graphics as Gfx;
using Toybox.System as Sys;
using Toybox.Lang;
using Toybox.Time;
using Toybox.Time.Gregorian;
using Toybox.ActivityMonitor;

class philippewatchfaceView extends WatchUi.WatchFace {
	var fontPhillipe = null;
	var fontBerlin = null;
	var font8Bit = null;
    function initialize() {
        WatchFace.initialize();
    }

    // Load your resources here
    function onLayout(dc) {
    	fontPhillipe = WatchUi.loadResource(Rez.Fonts.philippeH);
    	fontBerlin = WatchUi.loadResource(Rez.Fonts.berlin);
    	font8Bit = WatchUi.loadResource(Rez.Fonts.eightBit);
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
        //var min = 58;//clockTime.min;
		var dateString = Lang.format(
//		    "$1$:$2$:$3$ $4$ $5$ $6$ $7$",
			"$1$\n$2$\n$3$",
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
        dc.setColor(Gfx.COLOR_RED, Gfx.COLOR_TRANSPARENT);
        dc.drawText(dc.getWidth()/2, 0, fontBerlin, "ian.grainger@gmail.com", Gfx.TEXT_JUSTIFY_CENTER);
        
        dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT);
        
        dc.drawText(dc.getWidth()-10,13, font8Bit, getCaloriesStr() + " ", Gfx.TEXT_JUSTIFY_RIGHT);
        
        dc.drawText(dc.getWidth()/2+43-20, dc.getHeight()/2-55, fontPhillipe, hour.toString(), Gfx.TEXT_JUSTIFY_RIGHT);
        dc.drawText(dc.getWidth()/2+43-20, dc.getHeight()/2+11+4, fontPhillipe, clockTime.min.format("%02d"), Gfx.TEXT_JUSTIFY_RIGHT);
        
        var infoStr = dateString + "\nHR\n" + getHR() + "\n" + getNotificationStr();
        dc.drawText(dc.getWidth()-10, 36, font8Bit, infoStr, Gfx.TEXT_JUSTIFY_RIGHT);
        
        dc.drawText(0, dc.getHeight()/2, font8Bit, getConnectionStr(), Gfx.TEXT_JUSTIFY_LEFT);
        
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

	function getHR() {
		// get a HeartRateIterator object; oldest sample first
		var hrIterator = ActivityMonitor.getHeartRateHistory(null, true);
		var next = hrIterator.next();
		if(next == null)
			{return 0;}
		else
			{return next.heartRate;}
	}
	
	function getSteps() {
		var info = ActivityMonitor.getInfo();
		var steps = info.steps;
		return steps;
	}
	
	function getCaloriesStr() {
		return "("+getCalories();
	}
	
	function getCalories() {
		var info = ActivityMonitor.getInfo();
		var calories = info.calories;
		return calories;
	}
	
	function getNotificationStr() {
		var notificationCount = getNotificationCount();
		if(notificationCount == 0) { return "";}
		if(notificationCount == 1) { return "#  ";}
		if(notificationCount > 9) { return "#" + notificationCount;}
		else {return "#" + notificationCount + " ";}
	}
	
	function getNotificationCount() {
		var mySettings = Sys.getDeviceSettings();
		return mySettings.notificationCount;
	}
	function getConnectionStr() {
        if(getConnectionAvailable()) {return "$";}
        else {return "X";}
	}
	function getConnectionAvailable() {
		var mySettings = Sys.getDeviceSettings();
		return mySettings.phoneConnected;
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
