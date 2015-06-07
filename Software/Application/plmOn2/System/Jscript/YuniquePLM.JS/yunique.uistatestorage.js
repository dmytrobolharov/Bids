Core.UIStateStorage = (function () {
    var undefined;
	var currentPage = document.location.pathname.match(/[^\/]+$/)[0];

    function Singleton()  {
        var Storage = new Core.Storage.Local();

        function getUserName() {
            var username;
            try {
                username = Storage.read("User")["userId"];/*!!!Don't forget to change UserName to UserID!!!!*/
            } catch(e) {}

            return username;
        }

        function getAllSettings() {
            if (!Storage.read("UIStateStorage")) {
                Storage.writeJSON("UIStateStorage", {});
            }
            if (!Storage.read("UIStateStorage")[userName]) {
                var temp = {};
                temp[userName] = {};
                Storage.writeJSON("UIStateStorage", temp);
            }
			
            var allsettings = Storage.read("UIStateStorage")[userName][currentPage];

            return allsettings;
        }

        function getPathArray(path) {
            // \ / . ,
            path = path.split(/\/|\\|\.|\,/);

            if (!path[0]) {
                path.splice(0, 1)
            }

            if (!path[path.length-1]) {
                path.splice(-1, 1)
            }

            return path;
        }

        function getObjectForPath(path) {
            var path = getPathArray(path),
                objectToReturn;

            for (var i = 0, l = path.length; i < l; i++) {
                try {
                    objectToReturn = settings[path[i]] || objectToReturn[path[i]];
                } catch(e) {
                    break;
                }
            }

            return objectToReturn;
        }

        function reReadStorage() {
            settings = getAllSettings();
        }

        var userName = getUserName(),
            settings = getAllSettings();

        return {
            get: function(path) {
                return getObjectForPath(path);
            },
            set: function(path, data) {
                var path = getPathArray(path),
                    newData = {};

                for (var l = path.length, i = l-1; i !== -1; i--) {
                    var wrapper = {};
                    if (i === l-1) {
                        wrapper[path[i]] = data;
                        newData = wrapper;
                    } else {
                        wrapper[path[i]] = newData;
                        newData = wrapper;
                    }
                }

                var preLastWrapper = {};
                preLastWrapper[currentPage] = newData;
                var lastWrapper = {};
                lastWrapper[userName] = preLastWrapper;
                newData = lastWrapper;

                Storage.writeJSON('UIStateStorage', newData);
                reReadStorage();
            }
        };
    }

    var instance;

    return  (function() {
        if(instance === undefined)  {
            instance = new Singleton();
        }

        return  instance;
    })();
})();