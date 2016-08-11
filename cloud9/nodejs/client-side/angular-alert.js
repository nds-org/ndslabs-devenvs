angular
.module('ngAlert', [])
.service('AlertService', [ '$timeout',
  function($timeout){
    return function(maxAlerts, delayTime) {
        // Noop or default parameters
        if (arguments.length === 0) {
          maxAlerts = 5;
          delayTime = 3000;
        }
        
        if (arguments.length === 1) {
          delayTime = 3000;
        }
        
        var alertService = { 
            alerts: [],
            maxAlerts: maxAlerts,
            delayTime: delayTime,
            // Queues up a new alert to be displayed
            enqueue: function(alert) {
                // Properties cannot be assigned to strings, so we'll wrap this in a simple object
                if (!angular.isObject(alert)) {
                  alert = { message: alert };
                }
                
                // Set a timeout to get rid of the alert after delayTime expires
                if (alertService.delayTime > 0) {
                    alert.timeout = $timeout(alertService.dequeue, alertService.delayTime);
                }
                // If we go above maxAlerts, free up a spot and cancel its timeout
                if (alertService.maxAlerts > 0 && alertService.alerts.length >= alertService.maxAlerts) {
                    alertService.dequeue();
                }
                alertService.alerts.push(alert);
            },
            // Makes room for a new alert
            dequeue: function() {
              var alert = alertService.alerts.shift();
              if (alert && alert.timeout) {
                $timeout.cancel(alert.timeout);
              }
            },
            acknowledge: function($index) {
              var alert = alertService.alerts.splice($index, 1);
            }
        };
        
        return alertService;
    };
  }]);
