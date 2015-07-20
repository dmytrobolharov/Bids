// IE8, IE9 "JSON is undefind" fix
// IE8, IE9 "JSON is undefind" fix
;var JSON = JSON || {};
// implement JSON.stringify serialization
JSON.stringify = JSON.stringify || function(obj) {
    var t = typeof (obj);
    if(t != "object" || obj === null) {
        if(t == "string") {
            obj = '"' + obj + '"';
        }
        return String(obj);
    } else {
        var json = [],
            arr = (obj && obj.constructor == Array),
            v;
        for(var n in obj) {
            v = obj[n];
            t = typeof (v);
            if(t == "string") {
                v = '"' + v + '"';
            } else if(t == "object" && v !== null) {
                v = JSON.stringify(v);
            }
            json.push((arr ? "" : '"' + n + '":') + String(v));
        }
        return (arr ? "[" : "{") + String(json) + (arr ? "]" : "}");
    }
};
// implement JSON.parse de-serialization
JSON.parse = JSON.parse || function(str) {
    if(str === "") {
        str = '""';
    }
    eval("var p=" + str + ";");
    return p;
};

var Yunique = Yunique || {};

Yunique.Data = Yunique.Data = {}

// check if HTML5 local storage supports
Yunique.Data.supportsStorage = function() {
    try {
        return 'localStorage' in window && window['localStorage'] !== null;
    } catch (e) {
        return false;
    }
};

// Authentication methods
Yunique.Auth = Yunique.Auth || {};
Yunique.Auth.getYuniqueAPI = function() {
    var API = {};
//    if(Yunique.Data.supportsStorage()) {
//        try {
//            API = JSON.parse(window.localStorage.getItem('Yunique.API'));
//        } catch (e) {
//            API = { 'REST': '/YuniqueAPI.REST', 'Toolkit': '/Yunique.Toolkit.API' };
//        }
//    } else {
//        API = { 'REST': '/YuniqueAPI.REST', 'Toolkit': '/Yunique.Toolkit.API' };
//    }
    return { 'REST': 'http://199.254.197.149/yuniqueapitrk.rest', 'Toolkit': '' };
};
//Yunique.Auth.getYuniqueUser = function() {
////    var user = {};
////    if(Yunique.Data.supportsStorage()) {
////        try {
////            user = JSON.parse(window.localStorage.getItem('Yunique.User'));
////        } catch (e) {
////            user = { 'UserName': '', 'Password': '' };
////        }
////    } else {
////        user = { 'UserName': '', 'Password': '' };
////    }
////    return user || { 'UserName': '', 'Password': '' };
//};
Yunique.Auth.getYuniqueClient = function() {
    return {
        'clientID': '40000000-0000-0000-0000-000000000018',
        'clientPass': 'plmon1234@'
    };
};
Yunique.Auth.getYuniqueUser = function() {
    return {
        'UserName': 'administrator',
        'Password': 'plmon1234@'
    };
};
Yunique.Auth.config = {
    'api': Yunique.Auth.getYuniqueAPI(),
    'user': Yunique.Auth.getYuniqueUser(),
    'WSClient': Yunique.Auth.getYuniqueClient()
};
Yunique.Auth.getTimeStamp = function() {
    var ISODateString = function(d) {
        function pad(n) { return n < 10 ? '0' + n : n }
        return d.getUTCFullYear() + '-'
            + pad(d.getUTCMonth() + 1) + '-'
            + pad(d.getUTCDate()) + 'T'
            + pad(d.getUTCHours()) + ':'
            + pad(d.getUTCMinutes()) + ':'
            + pad(d.getUTCSeconds()) + 'Z'
    };
    // Produce a timestamp in UTC with format of 'YYYY-MM-DDThh:mm.ssZ'
    var d = new Date(),
        n = ISODateString(d);
    return n;
};
Yunique.Auth.getHeaderSignature = function(stringToSign, secret, timeStamp, method) {
    var salt = 'Yunique.API;' + method + ';',
        fullStringToSign = salt + stringToSign + ';' + timeStamp,
        hashedString = CryptoJS.HmacMD5(fullStringToSign, secret).toString(CryptoJS.enc.Base64);
    return hashedString;
};
Yunique.Auth.constructAddress = function(endpoint, verb, params, args, apiREST) {
    var p,
        urlAppendix = '';

    if(params != null) {
        p = { Params: null };
        if(verb == 'GET' || verb == 'DELETE') {
            p.Params = params;
            urlAppendix = '?params=' + JSON.stringify(p);
        }
    }
    if(args) {
        for(var prop in args) {
            var arg = prop + '=' + args[prop];
            urlAppendix += urlAppendix ? ('&' + arg) : ('?' + arg);
        }
    }
    if(apiREST.lastIndexOf('/') == apiREST.length - 1) {
        apiREST = apiREST.substring(0, apiREST.length - 1);
    }

    //console.log(apiREST + endpoint + urlAppendix);

    return apiREST + endpoint + urlAppendix;
};
Yunique.Auth.massageBody = function(obj) {
    var Params = {
        Params: {
            ParamRecord: []
        }
    };
    $(obj).each(function(i){
        Params.Params.ParamRecord.push(this);
    });
    return '{"Params":"' + JSON.stringify(Params).split('"').join('\\"') + '"}';
};


// HTTP request methods
Yunique.Http = Yunique.Http || {};
Yunique.Http.call = function(method, endpoint, params, args, apiURL) {
    apiURL = (apiURL || Yunique.Auth.config.api.REST || '').toLowerCase();
    var user = Yunique.Auth.config.user || { 'UserName': '', 'Password': '' },
        client = Yunique.Auth.config.WSClient;
    var ts = Yunique.Auth.getTimeStamp(),
        svcUrl = Yunique.Auth.constructAddress(endpoint, method, params, args, apiURL),
        signature = Yunique.Auth.getHeaderSignature(svcUrl, client.clientPass + '&' + user.Password, ts, method),
        ajaxObj = {
            type: method,
            dataType: 'json',
            contentType: 'application/json',
            url: svcUrl,
            headers: {
                'Accept': 'application/json',
                'Content-Type': 'application/json',
                'KeyID': client.clientID,
                'WSClientID': client.clientID,
                'PLMUserName': user.UserName,
                'TS': ts,
                'Signature': signature
            }
        };
    if(method == "POST" || method == "PUT") {
        ajaxObj.data = Yunique.Auth.massageBody(params);
    }
    jQuery.support.cors = true;
    return $.ajax(ajaxObj);
};
Yunique.Http.get = function(endpoint, params, args, apiURL) {
    return Yunique.Http.call('GET', endpoint, params, args, apiURL);
};
Yunique.Http.put = function(endpoint, params, args, apiURL) {
    return Yunique.Http.call('PUT', endpoint, params, args, apiURL);
};
Yunique.Http.post = function(endpoint, params, args, apiURL) {
    return Yunique.Http.call('POST', endpoint, params, args, apiURL);
};
Yunique.Http.delete = function(endpoint, params, args, apiURL) {
    return Yunique.Http.call('DELETE', endpoint, params, args, apiURL);
};

// Yunique SDK common methods
Yunique.Data.getUrlKey = function(name, place) {
    name = name.replace(/[\[]/, '\\\[').replace(/[\]]/, '\\\]');
    var regexS = '[\\?&]' + name + '=([^&#]*)',
        regex = new RegExp(regexS),
        results = regex.exec(place || window.location.href);
    if(results == null) {
        return '';
    } else {
        return results[1];
    }
};
Yunique.Data.objLength = function(obj) {
    var len = 0;
    for(var key in obj) {
        if(obj.hasOwnProperty(key)) len++;
    }
    if(!len || len == 0) {
        len = 1;
    }
    return len;
};
Yunique.Data.objToLowerCase = function(obj, res) {
    try {
        var res = {};
        for(var prop in obj) {
            var propLC = prop.toLowerCase();
            res[propLC] = obj[prop];
            if(typeof res[propLC] === 'object') {
                res[propLC] = Yunique.Data.objToLowerCase(obj[prop], res[propLC]);
            }
        }
        return res;
    } catch(e) {
        return obj;
    }
};
Yunique.Data.getCommentObj = function(pk, name, data) {
    var cmntType = '';
    for (var prop in data) {
        if (prop.indexOf('CommentType') !== -1) {
            cmntType = data[prop];
            break;
        }
    }
    var result = {};
    try {
        var pkID = data[pk] || '';
        result = {
            '0': pkID,
            '1': {
                '0': { 'alias': pk, 'value': pkID },
                '1': { 'alias': 'Comment', 'value': data[name] },
                '2': { 'alias': 'CreatedBy', 'value': data.CUser + '&nbsp&nbsp' + data.CDate },
                '3': { 'alias': 'ModifiedBy', 'value': data.MUser + '&nbsp&nbsp' + data.MDate },
                '4': { 'alias': 'CommentType', 'value': cmntType }
            }
        };
    } catch(e) {
        result = {};
    }
    return result;
};
Yunique.Data.schemaDriven = function(format, schema, data, lookups) {
    schema = Yunique.Data.objToLowerCase(schema);
    var columns = schema.newdataset ? schema.newdataset.table.column : schema.table.column,
        headerObj = {};
    if(!columns) {
        return {};
    }
//    if(typeof data[0] !== 'object') {
//        commentCnt = 1;
//    } else {
//        for(var prop in commentData.pMaterialComment) {
//            commentCnt += 1;
//        }
//    }
    if(format.toLowerCase() === 'header') {
        $.each(columns, function(i) {
            try {
                if(this['@visible'].toLowerCase() === 'false') {
                    return true;
                }
            } catch(e) {
                return true;
            }
            try {
                if(this['@pk'] && this['@pk'].toLowerCase() === 'true') {
                    return true;
                }
            } catch(e) {}
            var dataFieldValue = data[this['@name']] || '',
                columnNum,
                orderNum;
            try {
                if (!this['@column']) {
                    columnNum = 1;
                } else {
                    columnNum = parseInt(this['@column']);
                }
            } catch (e) {
                columnNum = 1;
            }
            try {
                if (!this['@order']) {
                    orderNum = 999;
                } else {
                    orderNum = parseInt(this['@order']);
                }
            } catch (e) {
                orderNum = 999;
            }
            //        if(!dataFieldValue) {
            //dataFieldValue = this['@DefaultValue'] || ""; // handle default value from schema
            //            dataFieldValue = '';
            //        }
            // Date
            try {
                if(this['@datatype'] === 'datetime') {
                    dataFieldValue = dataFieldValue.split(' ')[0].replace(/\./g, '/');
                }
            } catch(e) {}
            // Money
            try {
                if(this['@datatype'] === 'money') {
                    dataFieldValue = parseFloat(dataFieldValue).toFixed(2);
                }
            } catch(e) {}
            // Lookups
            try {
                if(this['@type'] === 'dropdownlist') {
                    if(this.lookuptable && lookups) {
                        var lookupField = this.lookuptable['@parentidfield'];
                        if(lookups[lookupField]) {
                            if(typeof lookups[lookupField][0] === 'object') {
                                var lookupsVal = '';
                                for(var i in lookups[lookupField]) {
                                    if(lookups[lookupField][i].key === dataFieldValue) {
                                        lookupsVal = lookups[lookupField][i].value;
                                        break;
                                    }
                                }
                                dataFieldValue = lookupsVal;
                            } else {
                                if(lookups[lookupField].key === dataFieldValue) {
                                    dataFieldValue = lookups[lookupField].value;
                                }
                            }
                        } else {
                            dataFieldValue = '';
                        }
                    }
                }
            } catch(e) {}
            if(!headerObj[columnNum]) {
                headerObj[columnNum] = [];
            }
            headerObj[columnNum].push([this['@alias'], dataFieldValue, orderNum]);
        });
        var result = {},
            columnOrdered = [];
        for(var prop in headerObj) {
            columnOrdered = headerObj[prop].sort(function(a, b) {
                return a[2] - b[2];
            });
            result[prop] = {};
            for(var i = 0, l = columnOrdered.length; i < l; i++) {
                result[prop][i] = { 'Name': columnOrdered[i][0], 'Value': columnOrdered[i][1], 'Order': columnOrdered[i][2] };
            }

        }
        return result;
    } else if (format.toLowerCase() === 'comment') {
        var pk = '',
            commentField = '';
        $.each(columns, function(i) {
            try {
                if(this['@pk'] && this['@pk'].toLowerCase() === 'true') {
                    pk = this['@name'];
                }
            } catch(e) {
                pk = '';
            }
            try {
                if(this['@name'].indexOf('Comment') != -1 && (!this['@pk'] || this['@pk'].toLowerCase() !== 'true')) {
                    commentField = this['@name'];
                }
            } catch(e) {
                commentField = '';
            }
        });
        var result = {},
            cnt = 0;
        for(var prop in data) {
            if(typeof data[prop] === 'object') {

                var cmnt = Yunique.Data.getCommentObj(pk, commentField, data[prop]);
                result[cnt] = cmnt[1];
                cnt++;
            } else {
                var cmnt = Yunique.Data.getCommentObj(pk, commentField, data);
                result[0] = cmnt[1];
                break;
            }
        }
        return result;
    }
};
Yunique.Data.getImageServerUrl = function(successCB, errCB) {
    var toolkitAPI = '';
    try {
        toolkitAPI = Yunique.Auth.config.api.Toolkit;
    } catch(e) {
        toolkitAPI = '';
    }
    Yunique.Http.get('/AppSetting/Server.config/ImageServer.json', null, null, toolkitAPI)
        .then(function(resp) {
            try {
                if(successCB) {
                    successCB(resp.appSettings[0].appSettingValue);
                }
            } catch(e) {
                if(errCB) {
                    errCB();
                }
            }
        }, function(err) {
            if(errCB) {
                errCB();
            }
        });
};
Yunique.Data.convertImageURL = function (imageLink, width, height, scaleMode) {
    var replacedUrl = "";
    var a = CryptoJS.HmacMD5('')
    var user = Yunique.Auth.config.user || { 'UserName': '', 'Password': '' },
        client = Yunique.Auth.config.WSClient;
    if (!imageLink || imageLink.length == 0) {
        replacedUrl = "/images/nophoto.png";
    } else {
        var timeStamp = Yunique.Auth.getTimeStamp(),
            signature = Yunique.Auth.getHeaderSignature(imageLink.split('?')[0],client.clientPass + '&' + user.Password, timeStamp, 'GET');

        replacedUrl = imageLink.replace('{un}', encodeURIComponent(user.UserName));
        replacedUrl = replacedUrl.replace('{ts}', encodeURIComponent(timeStamp));
        replacedUrl = replacedUrl.replace('{snt}', encodeURIComponent(signature));
        replacedUrl = replacedUrl.replace('{sid}', user.SessionID);
        replacedUrl = replacedUrl + (width ? ('&w=' + width) : '') + (height ? ('&h=' + height) : '') + '&mode=' + (scaleMode || 'max');
    }
    return replacedUrl;
};
Yunique.Data.getTranslatedString = function(trAll, str) {
    var result = '';
    try {
        if(typeof trAll[0] === 'object') {
            for(var prop in trAll) {
                if(trAll[prop].DesignString === str) {
                    result = trAll[prop].TranslatedString;
                    break;
                }
            }
        } else {
            if(trAll.DesignString === str) {
                result = trAll.TranslatedString;
            }
        }
    } catch(e) {
        result = str;
    }
    return result || str;
};
Yunique.Data.getYuniqueData = function() {
    var data = {};
    if(Yunique.Data.supportsStorage()) {
        try {
            data = JSON.parse(window.localStorage.getItem('Yunique.Data'));
        } catch (e) {
            data = {};
        }
    } else {
        data = {};
    }
    return data || {};
};
Yunique.Data.getAppRoot = function() {
    var appRoot = '';
    try {
        appRoot = Yunique.Data.getYuniqueData()['AppRoot'];
    } catch(e) {
        appRoot = '../';
    }
    return appRoot;
};