var Yunique = window.Yunique = window.Yunique || {};
var Core = Yunique.Core = Yunique.Core || {};

var storageIsSupported = function (typeOfStorage) {
    try {
        return typeOfStorage in window && window[typeOfStorage] !== null;
    } catch (e) {
        return false;
    }
};

var isEmptyObj = function(obj) {
    for(var key in obj) {
        if(obj.hasOwnProperty(key)) {
            return false;
        }
    }
    return true;
}

// deep merge of two objects
var extendObj = function(oldVal, newVal) {
    var target = oldVal;
    if (typeof target !== "object" && Object.prototype.toString.call(target) !== '[object Array]') {
        target = {};
    }
    if (newVal != null && !isEmptyObj(newVal)) {
        var targetProp, newValProp, newValPropIsArray;
        for (var prop in newVal) {
            targetProp = target[prop];
            newValProp = newVal[prop];
            // Prevent never-ending loop
            if ( target === newValProp ) {
                continue;
            }
            // Recurse if we're merging plain objects or arrays
            if (newValProp && ((Object.prototype.toString.call(newValProp) === '[object Object]'))) {
                if (newValPropIsArray) {
                    newValPropIsArray = false;
                    targetProp = (targetProp && (Object.prototype.toString.call(targetProp) === '[object Array]')) ? targetProp : [];
                } else {
                    targetProp = (targetProp && (Object.prototype.toString.call(targetProp) === '[object Object]')) ? targetProp : {};
                }
                target[prop] = extendObj(targetProp, newValProp);
            } else if (newValProp !== undefined) {
                target[prop] = newValProp;
            }
        }
    } else {
        target = newVal;
    }
    return target;
};

var read = function(key, typeOfStorage) {
    var item = window[typeOfStorage].getItem("Yunique." + key);
    try {
        return JSON.parse(item);
    } catch(e) {
        return item;
    }
};

var readAll = function(typeOfStorage) {
    var result = {},
        storage = window[typeOfStorage];
    for(var i = 0, len = storage.length; i<len; i++) {
        var key = storage.key(i);
        var value = storage[key];
        result[key] = (function() {
            try {
                return JSON.parse(value);
            } catch(e) {
                return value;
            }
        })();
    }
    return result;
};

var write =  function(key,  value, typeOfStorage) {
    window[typeOfStorage].setItem("Yunique." + key, value);
};

var writeJSON = function(key,  value, typeOfStorage) {
    var item = window[typeOfStorage].getItem("Yunique." + key);
    try {
        item = JSON.parse(item);
        if(typeof(item) == "object" && item !== null) {
            item = extendObj(item, value);
        } else {
            item = value;
        }
    } catch(e) {
        item = value;
    }
    window[typeOfStorage].setItem("Yunique." + key, JSON.stringify(item));
};

var remove = function(key, typeOfStorage) {
    window[typeOfStorage].removeItem("Yunique." + key);
};

var removeJSON = function(key, property, typeOfStorage) {
    var item = window[typeOfStorage].getItem("Yunique." + key);
    try {
        item = JSON.parse(item);
        if(item[property]) {
            delete item[property];
            window[typeOfStorage].setItem("Yunique." + key, JSON.stringify(item));
        }
    } catch(e) {}
};

var removeAll = function(typeOfStorage) {
    window[typeOfStorage].clear();
};

var StorageBase = function(type) {
    this.type = type;
    this.supported = storageIsSupported(type);
};
StorageBase.prototype.read = function(key) {
    return read(key, this.type);
};
StorageBase.prototype.readAll = function() {
    return readAll(this.type);
};
StorageBase.prototype.write = function(key, value) {
    write(key, value, this.type);
};
StorageBase.prototype.writeJSON = function(key, value) {
    writeJSON(key, value, this.type);
};
StorageBase.prototype.remove = function(key) {
    remove(key, this.type);
};
StorageBase.prototype.removeJSON = function(key, property) {
    removeJSON(key, property, this.type);
};
StorageBase.prototype.removeAll = function() {
    removeAll(this.type);
};

Core.Storage = {
    Local: function() {
        return new StorageBase('localStorage');
    },
    Session: function() {
        return new StorageBase('sessionStorage');;
    }
};