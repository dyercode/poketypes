parcelRequire=function(e,r,t,n){var i,o="function"==typeof parcelRequire&&parcelRequire,u="function"==typeof require&&require;function f(t,n){if(!r[t]){if(!e[t]){var i="function"==typeof parcelRequire&&parcelRequire;if(!n&&i)return i(t,!0);if(o)return o(t,!0);if(u&&"string"==typeof t)return u(t);var c=new Error("Cannot find module '"+t+"'");throw c.code="MODULE_NOT_FOUND",c}p.resolve=function(r){return e[t][1][r]||r},p.cache={};var l=r[t]=new f.Module(t);e[t][0].call(l.exports,p,l,l.exports,this)}return r[t].exports;function p(e){return f(p.resolve(e))}}f.isParcelRequire=!0,f.Module=function(e){this.id=e,this.bundle=f,this.exports={}},f.modules=e,f.cache=r,f.parent=o,f.register=function(r,t){e[r]=[function(e,r){r.exports=t},{}]};for(var c=0;c<t.length;c++)try{f(t[c])}catch(e){i||(i=e)}if(t.length){var l=f(t[t.length-1]);"object"==typeof exports&&"undefined"!=typeof module?module.exports=l:"function"==typeof define&&define.amd?define(function(){return l}):n&&(this[n]=l)}if(parcelRequire=f,i)throw i;return f}({"kCX8":[function(require,module,exports) {
"use strict";try{self["workbox:core:6.1.2"]&&_()}catch(c){}
},{}],"U5J5":[function(require,module,exports) {
"use strict";Object.defineProperty(exports,"__esModule",{value:!0}),exports.messages=void 0,require("../../_version.js");const e={"invalid-value":({paramName:e,validValueDescription:r,value:t})=>{if(!e||!r)throw new Error("Unexpected input to 'invalid-value' error.");return`The '${e}' parameter was given a value with an `+`unexpected value. ${r} Received a value of `+`${JSON.stringify(t)}.`},"not-an-array":({moduleName:e,className:r,funcName:t,paramName:a})=>{if(!(e&&r&&t&&a))throw new Error("Unexpected input to 'not-an-array' error.");return`The parameter '${a}' passed into `+`'${e}.${r}.${t}()' must be an array.`},"incorrect-type":({expectedType:e,paramName:r,moduleName:t,className:a,funcName:n})=>{if(!(e&&r&&t&&n))throw new Error("Unexpected input to 'incorrect-type' error.");return`The parameter '${r}' passed into `+`'${t}.${a?a+".":""}`+`${n}()' must be of type ${e}.`},"incorrect-class":({expectedClass:e,paramName:r,moduleName:t,className:a,funcName:n,isReturnValueProblem:o})=>{if(!e||!t||!n)throw new Error("Unexpected input to 'incorrect-class' error.");return o?"The return value from "+`'${t}.${a?a+".":""}${n}()' `+`must be an instance of class ${e.name}.`:`The parameter '${r}' passed into `+`'${t}.${a?a+".":""}${n}()' `+`must be an instance of class ${e.name}.`},"missing-a-method":({expectedMethod:e,paramName:r,moduleName:t,className:a,funcName:n})=>{if(!(e&&r&&t&&a&&n))throw new Error("Unexpected input to 'missing-a-method' error.");return`${t}.${a}.${n}() expected the `+`'${r}' parameter to expose a '${e}' method.`},"add-to-cache-list-unexpected-type":({entry:e})=>"An unexpected entry was passed to 'workbox-precaching.PrecacheController.addToCacheList()' The entry "+`'${JSON.stringify(e)}' isn't supported. You must supply an array of `+"strings with one or more characters, objects with a url property or Request objects.","add-to-cache-list-conflicting-entries":({firstEntry:e,secondEntry:r})=>{if(!e||!r)throw new Error("Unexpected input to 'add-to-cache-list-duplicate-entries' error.");return"Two of the entries passed to 'workbox-precaching.PrecacheController.addToCacheList()' had the URL "+`${e._entryId} but different revision details. Workbox is `+"unable to cache and version the asset correctly. Please remove one of the entries."},"plugin-error-request-will-fetch":({thrownError:e})=>{if(!e)throw new Error("Unexpected input to 'plugin-error-request-will-fetch', error.");return"An error was thrown by a plugins 'requestWillFetch()' method. "+`The thrown error message was: '${e.message}'.`},"invalid-cache-name":({cacheNameId:e,value:r})=>{if(!e)throw new Error("Expected a 'cacheNameId' for error 'invalid-cache-name'");return"You must provide a name containing at least one character for "+`setCacheDetails({${e}: '...'}). Received a value of `+`'${JSON.stringify(r)}'`},"unregister-route-but-not-found-with-method":({method:e})=>{if(!e)throw new Error("Unexpected input to 'unregister-route-but-not-found-with-method' error.");return"The route you're trying to unregister was not  previously "+`registered for the method type '${e}'.`},"unregister-route-route-not-registered":()=>"The route you're trying to unregister was not previously registered.","queue-replay-failed":({name:e})=>`Replaying the background sync queue '${e}' failed.`,"duplicate-queue-name":({name:e})=>`The Queue name '${e}' is already being used. `+"All instances of backgroundSync.Queue must be given unique names.","expired-test-without-max-age":({methodName:e,paramName:r})=>`The '${e}()' method can only be used when the `+`'${r}' is used in the constructor.`,"unsupported-route-type":({moduleName:e,className:r,funcName:t,paramName:a})=>`The supplied '${a}' parameter was an unsupported type. `+`Please check the docs for ${e}.${r}.${t} for `+"valid input types.","not-array-of-class":({value:e,expectedClass:r,moduleName:t,className:a,funcName:n,paramName:o})=>`The supplied '${o}' parameter must be an array of `+`'${r}' objects. Received '${JSON.stringify(e)},'. `+`Please check the call to ${t}.${a}.${n}() `+"to fix the issue.","max-entries-or-age-required":({moduleName:e,className:r,funcName:t})=>"You must define either config.maxEntries or config.maxAgeSeconds"+`in ${e}.${r}.${t}`,"statuses-or-headers-required":({moduleName:e,className:r,funcName:t})=>"You must define either config.statuses or config.headers"+`in ${e}.${r}.${t}`,"invalid-string":({moduleName:e,funcName:r,paramName:t})=>{if(!t||!e||!r)throw new Error("Unexpected input to 'invalid-string' error.");return`When using strings, the '${t}' parameter must start with `+"'http' (for cross-origin matches) or '/' (for same-origin matches). "+`Please see the docs for ${e}.${r}() for `+"more info."},"channel-name-required":()=>"You must provide a channelName to construct a BroadcastCacheUpdate instance.","invalid-responses-are-same-args":()=>"The arguments passed into responsesAreSame() appear to be invalid. Please ensure valid Responses are used.","expire-custom-caches-only":()=>"You must provide a 'cacheName' property when using the expiration plugin with a runtime caching strategy.","unit-must-be-bytes":({normalizedRangeHeader:e})=>{if(!e)throw new Error("Unexpected input to 'unit-must-be-bytes' error.");return"The 'unit' portion of the Range header must be set to 'bytes'. "+`The Range header provided was "${e}"`},"single-range-only":({normalizedRangeHeader:e})=>{if(!e)throw new Error("Unexpected input to 'single-range-only' error.");return"Multiple ranges are not supported. Please use a  single start value, and optional end value. The Range header provided was "+`"${e}"`},"invalid-range-values":({normalizedRangeHeader:e})=>{if(!e)throw new Error("Unexpected input to 'invalid-range-values' error.");return"The Range header is missing both start and end values. At least one of those values is needed. The Range header provided was "+`"${e}"`},"no-range-header":()=>"No Range header was found in the Request provided.","range-not-satisfiable":({size:e,start:r,end:t})=>`The start (${r}) and end (${t}) values in the Range are `+`not satisfiable by the cached response, which is ${e} bytes.`,"attempt-to-cache-non-get-request":({url:e,method:r})=>`Unable to cache '${e}' because it is a '${r}' request and `+"only 'GET' requests can be cached.","cache-put-with-no-response":({url:e})=>`There was an attempt to cache '${e}' but the response was not `+"defined.","no-response":({url:e,error:r})=>{let t=`The strategy could not generate a response for '${e}'.`;return r&&(t+=` The underlying error is ${r}.`),t},"bad-precaching-response":({url:e,status:r})=>`The precaching request for '${e}' failed`+(r?` with an HTTP status of ${r}.`:"."),"non-precached-url":({url:e})=>`createHandlerBoundToURL('${e}') was called, but that URL is `+"not precached. Please pass in a URL that is precached instead.","add-to-cache-list-conflicting-integrities":({url:e})=>"Two of the entries passed to 'workbox-precaching.PrecacheController.addToCacheList()' had the URL "+`${e} with different integrity values. Please remove one of them.`,"missing-precache-entry":({cacheName:e,url:r})=>`Unable to find a precached response in ${e} for ${r}.`,"cross-origin-copy-response":({origin:e})=>"workbox-core.copyResponse() can only be used with same-origin "+`responses. It was passed a response with origin ${e}.`};exports.messages=e;
},{"../../_version.js":"kCX8"}],"mgiq":[function(require,module,exports) {
"use strict";Object.defineProperty(exports,"__esModule",{value:!0}),exports.messageGenerator=void 0;var e=require("./messages.js");require("../../_version.js");const r=(e,...r)=>{let s=e;return r.length>0&&(s+=` :: ${JSON.stringify(r)}`),s},s=(r,s={})=>{const t=e.messages[r];if(!t)throw new Error(`Unable to find message for code '${r}'.`);return t(s)},t=r;exports.messageGenerator=t;
},{"./messages.js":"U5J5","../../_version.js":"kCX8"}],"sMOR":[function(require,module,exports) {
"use strict";Object.defineProperty(exports,"__esModule",{value:!0}),exports.WorkboxError=void 0;var e=require("../models/messages/messageGenerator.js");require("../_version.js");class r extends Error{constructor(r,s){super((0,e.messageGenerator)(r,s)),this.name=r,this.details=s}}exports.WorkboxError=r;
},{"../models/messages/messageGenerator.js":"mgiq","../_version.js":"kCX8"}],"fLQu":[function(require,module,exports) {
"use strict";Object.defineProperty(exports,"__esModule",{value:!0}),exports.assert=void 0;var r=require("../_private/WorkboxError.js");require("../_version.js");const o=(o,e)=>{if(!Array.isArray(o))throw new r.WorkboxError("not-an-array",e)},e=(o,e,t)=>{if("function"!==typeof o[e])throw t.expectedMethod=e,new r.WorkboxError("missing-a-method",t)},t=(o,e,t)=>{if(typeof o!==e)throw t.expectedType=e,new r.WorkboxError("incorrect-type",t)},i=(o,e,t)=>{if(!(o instanceof e))throw t.expectedClass=e,new r.WorkboxError("incorrect-class",t)},s=(o,e,t)=>{if(!e.includes(o))throw t.validValueDescription=`Valid values are ${JSON.stringify(e)}.`,new r.WorkboxError("invalid-value",t)},n=(o,e,t)=>{const i=new r.WorkboxError("not-array-of-class",t);if(!Array.isArray(o))throw i;for(const r of o)if(!(r instanceof e))throw i},a=null;exports.assert=null;
},{"../_private/WorkboxError.js":"sMOR","../_version.js":"kCX8"}],"RSRA":[function(require,module,exports) {
"use strict";Object.defineProperty(exports,"__esModule",{value:!0}),exports.logger=void 0,require("../_version.js");const e=null;exports.logger=null;
},{"../_version.js":"kCX8"}],"uMvU":[function(require,module,exports) {
"use strict";try{self["workbox:routing:6.1.2"]&&_()}catch(t){}
},{}],"srwG":[function(require,module,exports) {
"use strict";Object.defineProperty(exports,"__esModule",{value:!0}),exports.validMethods=exports.defaultMethod=void 0,require("../_version.js");const e="GET";exports.defaultMethod="GET";const t=["DELETE","GET","HEAD","PATCH","POST","PUT"];exports.validMethods=t;
},{"../_version.js":"uMvU"}],"Qwdb":[function(require,module,exports) {
"use strict";Object.defineProperty(exports,"__esModule",{value:!0}),exports.normalizeHandler=void 0;var e=require("workbox-core/_private/assert.js");require("../_version.js");const r=e=>e&&"object"==typeof e?e:{handle:e};exports.normalizeHandler=r;
},{"workbox-core/_private/assert.js":"fLQu","../_version.js":"uMvU"}],"BrpV":[function(require,module,exports) {
"use strict";Object.defineProperty(exports,"__esModule",{value:!0}),exports.Route=void 0;var e=require("workbox-core/_private/assert.js"),r=require("./utils/constants.js"),t=require("./utils/normalizeHandler.js");require("./_version.js");class s{constructor(e,s,o=r.defaultMethod){this.handler=(0,t.normalizeHandler)(s),this.match=e,this.method=o}setCatchHandler(e){this.catchHandler=(0,t.normalizeHandler)(e)}}exports.Route=s;
},{"workbox-core/_private/assert.js":"fLQu","./utils/constants.js":"srwG","./utils/normalizeHandler.js":"Qwdb","./_version.js":"uMvU"}],"URAM":[function(require,module,exports) {
"use strict";Object.defineProperty(exports,"__esModule",{value:!0}),exports.NavigationRoute=void 0;var e=require("workbox-core/_private/assert.js"),t=require("workbox-core/_private/logger.js"),r=require("./Route.js");require("./_version.js");class s extends r.Route{constructor(e,{allowlist:t=[/./],denylist:r=[]}={}){super(e=>this._match(e),e),this._allowlist=t,this._denylist=r}_match({url:e,request:t}){if(t&&"navigate"!==t.mode)return!1;const r=e.pathname+e.search;for(const s of this._denylist)if(s.test(r))return!1;return!!this._allowlist.some(e=>e.test(r))}}exports.NavigationRoute=s;
},{"workbox-core/_private/assert.js":"fLQu","workbox-core/_private/logger.js":"RSRA","./Route.js":"BrpV","./_version.js":"uMvU"}],"hWbL":[function(require,module,exports) {
"use strict";Object.defineProperty(exports,"__esModule",{value:!0}),exports.RegExpRoute=void 0;var e=require("workbox-core/_private/assert.js"),r=require("workbox-core/_private/logger.js"),o=require("./Route.js");require("./_version.js");class s extends o.Route{constructor(e,r,o){super(({url:r})=>{const o=e.exec(r.href);if(o&&(r.origin===location.origin||0===o.index))return o.slice(1)},r,o)}}exports.RegExpRoute=s;
},{"workbox-core/_private/assert.js":"fLQu","workbox-core/_private/logger.js":"RSRA","./Route.js":"BrpV","./_version.js":"uMvU"}],"ATI6":[function(require,module,exports) {
"use strict";Object.defineProperty(exports,"__esModule",{value:!0}),exports.getFriendlyURL=void 0,require("../_version.js");const e=e=>{return new URL(String(e),location.href).href.replace(new RegExp(`^${location.origin}`),"")};exports.getFriendlyURL=e;
},{"../_version.js":"kCX8"}],"KCOZ":[function(require,module,exports) {
"use strict";Object.defineProperty(exports,"__esModule",{value:!0}),exports.Router=void 0;var e=require("workbox-core/_private/assert.js"),t=require("workbox-core/_private/getFriendlyURL.js"),r=require("./utils/constants.js"),s=require("workbox-core/_private/logger.js"),o=require("./utils/normalizeHandler.js"),n=require("workbox-core/_private/WorkboxError.js");require("./_version.js");class a{constructor(){this._routes=new Map,this._defaultHandlerMap=new Map}get routes(){return this._routes}addFetchListener(){self.addEventListener("fetch",e=>{const{request:t}=e,r=this.handleRequest({request:t,event:e});r&&e.respondWith(r)})}addCacheListener(){self.addEventListener("message",e=>{if(e.data&&"CACHE_URLS"===e.data.type){const{payload:t}=e.data;0;const r=Promise.all(t.urlsToCache.map(t=>{"string"==typeof t&&(t=[t]);const r=new Request(...t);return this.handleRequest({request:r,event:e})}));e.waitUntil(r),e.ports&&e.ports[0]&&r.then(()=>e.ports[0].postMessage(!0))}})}handleRequest({request:e,event:t}){const r=new URL(e.url,location.href);if(!r.protocol.startsWith("http"))return void 0;const s=r.origin===location.origin,{params:o,route:n}=this.findMatchingRoute({event:t,request:e,sameOrigin:s,url:r});let a=n&&n.handler;const i=e.method;if(!a&&this._defaultHandlerMap.has(i)&&(a=this._defaultHandlerMap.get(i)),!a)return void 0;let u;try{u=a.handle({url:r,request:e,event:t,params:o})}catch(d){u=Promise.reject(d)}const h=n&&n.catchHandler;return u instanceof Promise&&(this._catchHandler||h)&&(u=u.catch(async s=>{if(h){0;try{return await h.handle({url:r,request:e,event:t,params:o})}catch(n){s=n}}if(this._catchHandler)return this._catchHandler.handle({url:r,request:e,event:t});throw s})),u}findMatchingRoute({url:e,sameOrigin:t,request:r,event:s}){const o=this._routes.get(r.method)||[];for(const n of o){let o;const a=n.match({url:e,sameOrigin:t,request:r,event:s});if(a)return o=a,Array.isArray(a)&&0===a.length?o=void 0:a.constructor===Object&&0===Object.keys(a).length?o=void 0:"boolean"==typeof a&&(o=void 0),{route:n,params:o}}return{}}setDefaultHandler(e,t=r.defaultMethod){this._defaultHandlerMap.set(t,(0,o.normalizeHandler)(e))}setCatchHandler(e){this._catchHandler=(0,o.normalizeHandler)(e)}registerRoute(e){this._routes.has(e.method)||this._routes.set(e.method,[]),this._routes.get(e.method).push(e)}unregisterRoute(e){if(!this._routes.has(e.method))throw new n.WorkboxError("unregister-route-but-not-found-with-method",{method:e.method});const t=this._routes.get(e.method).indexOf(e);if(!(t>-1))throw new n.WorkboxError("unregister-route-route-not-registered");this._routes.get(e.method).splice(t,1)}}exports.Router=a;
},{"workbox-core/_private/assert.js":"fLQu","workbox-core/_private/getFriendlyURL.js":"ATI6","./utils/constants.js":"srwG","workbox-core/_private/logger.js":"RSRA","./utils/normalizeHandler.js":"Qwdb","workbox-core/_private/WorkboxError.js":"sMOR","./_version.js":"uMvU"}],"GZP8":[function(require,module,exports) {
"use strict";Object.defineProperty(exports,"__esModule",{value:!0}),exports.getOrCreateDefaultRouter=void 0;var e=require("../Router.js");let r;require("../_version.js");const t=()=>(r||((r=new e.Router).addFetchListener(),r.addCacheListener()),r);exports.getOrCreateDefaultRouter=t;
},{"../Router.js":"KCOZ","../_version.js":"uMvU"}],"mBaQ":[function(require,module,exports) {
"use strict";Object.defineProperty(exports,"__esModule",{value:!0}),exports.registerRoute=i;var e=require("workbox-core/_private/logger.js"),r=require("workbox-core/_private/WorkboxError.js"),t=require("./Route.js"),o=require("./RegExpRoute.js"),u=require("./utils/getOrCreateDefaultRouter.js");function i(e,i,s){let n;if("string"==typeof e){const r=new URL(e,location.href);0;const o=({url:e})=>e.href===r.href;n=new t.Route(o,i,s)}else if(e instanceof RegExp)n=new o.RegExpRoute(e,i,s);else if("function"==typeof e)n=new t.Route(e,i,s);else{if(!(e instanceof t.Route))throw new r.WorkboxError("unsupported-route-type",{moduleName:"workbox-routing",funcName:"registerRoute",paramName:"capture"});n=e}return(0,u.getOrCreateDefaultRouter)().registerRoute(n),n}require("./_version.js");
},{"workbox-core/_private/logger.js":"RSRA","workbox-core/_private/WorkboxError.js":"sMOR","./Route.js":"BrpV","./RegExpRoute.js":"hWbL","./utils/getOrCreateDefaultRouter.js":"GZP8","./_version.js":"uMvU"}],"rimP":[function(require,module,exports) {
"use strict";Object.defineProperty(exports,"__esModule",{value:!0}),exports.setCatchHandler=t;var e=require("./utils/getOrCreateDefaultRouter.js");function t(t){(0,e.getOrCreateDefaultRouter)().setCatchHandler(t)}require("./_version.js");
},{"./utils/getOrCreateDefaultRouter.js":"GZP8","./_version.js":"uMvU"}],"ihF6":[function(require,module,exports) {
"use strict";Object.defineProperty(exports,"__esModule",{value:!0}),exports.setDefaultHandler=t;var e=require("./utils/getOrCreateDefaultRouter.js");function t(t){(0,e.getOrCreateDefaultRouter)().setDefaultHandler(t)}require("./_version.js");
},{"./utils/getOrCreateDefaultRouter.js":"GZP8","./_version.js":"uMvU"}],"BA8m":[function(require,module,exports) {
"use strict";Object.defineProperty(exports,"__esModule",{value:!0}),Object.defineProperty(exports,"NavigationRoute",{enumerable:!0,get:function(){return e.NavigationRoute}}),Object.defineProperty(exports,"RegExpRoute",{enumerable:!0,get:function(){return t.RegExpRoute}}),Object.defineProperty(exports,"registerRoute",{enumerable:!0,get:function(){return r.registerRoute}}),Object.defineProperty(exports,"Route",{enumerable:!0,get:function(){return u.Route}}),Object.defineProperty(exports,"Router",{enumerable:!0,get:function(){return n.Router}}),Object.defineProperty(exports,"setCatchHandler",{enumerable:!0,get:function(){return o.setCatchHandler}}),Object.defineProperty(exports,"setDefaultHandler",{enumerable:!0,get:function(){return i.setDefaultHandler}});var e=require("./NavigationRoute.js"),t=require("./RegExpRoute.js"),r=require("./registerRoute.js"),u=require("./Route.js"),n=require("./Router.js"),o=require("./setCatchHandler.js"),i=require("./setDefaultHandler.js");require("./_version.js");
},{"./NavigationRoute.js":"URAM","./RegExpRoute.js":"hWbL","./registerRoute.js":"mBaQ","./Route.js":"BrpV","./Router.js":"KCOZ","./setCatchHandler.js":"rimP","./setDefaultHandler.js":"ihF6","./_version.js":"uMvU"}],"JU0p":[function(require,module,exports) {
"use strict";Object.defineProperty(exports,"__esModule",{value:!0});var e=require("./index.js");Object.keys(e).forEach(function(r){"default"!==r&&"__esModule"!==r&&(r in exports&&exports[r]===e[r]||Object.defineProperty(exports,r,{enumerable:!0,get:function(){return e[r]}}))});
},{"./index.js":"BA8m"}],"UOvG":[function(require,module,exports) {
"use strict";Object.defineProperty(exports,"__esModule",{value:!0}),exports.cacheNames=void 0,require("../_version.js");const e={googleAnalytics:"googleAnalytics",precache:"precache-v2",prefix:"workbox",runtime:"runtime",suffix:"undefined"!=typeof registration?registration.scope:""},t=t=>[e.prefix,t,e.suffix].filter(e=>e&&e.length>0).join("-"),i=t=>{for(const i of Object.keys(e))t(i)},r={updateDetails:t=>{i(i=>{"string"==typeof t[i]&&(e[i]=t[i])})},getGoogleAnalyticsName:i=>i||t(e.googleAnalytics),getPrecacheName:i=>i||t(e.precache),getPrefix:()=>e.prefix,getRuntimeName:i=>i||t(e.runtime),getSuffix:()=>e.suffix};exports.cacheNames=r;
},{"../_version.js":"kCX8"}],"fCxI":[function(require,module,exports) {
"use strict";function e(e,r){const t=new URL(e);for(const n of r)t.searchParams.delete(n);return t.href}async function r(r,t,n,o){const c=e(t.url,n);if(t.url===c)return r.match(t,o);const s={...o,ignoreSearch:!0},a=await r.keys(t,s);for(const u of a){if(c===e(u.url,n))return r.match(u,o)}}Object.defineProperty(exports,"__esModule",{value:!0}),exports.cacheMatchIgnoreParams=r,require("../_version.js");
},{"../_version.js":"kCX8"}],"KCEd":[function(require,module,exports) {
"use strict";Object.defineProperty(exports,"__esModule",{value:!0}),exports.Deferred=void 0,require("../_version.js");class e{constructor(){this.promise=new Promise((e,r)=>{this.resolve=e,this.reject=r})}}exports.Deferred=e;
},{"../_version.js":"kCX8"}],"RaTe":[function(require,module,exports) {
"use strict";Object.defineProperty(exports,"__esModule",{value:!0}),exports.quotaErrorCallbacks=void 0,require("../_version.js");const e=new Set;exports.quotaErrorCallbacks=e;
},{"../_version.js":"kCX8"}],"nHsh":[function(require,module,exports) {
"use strict";Object.defineProperty(exports,"__esModule",{value:!0}),exports.executeQuotaErrorCallbacks=o;var r=require("../_private/logger.js"),e=require("../models/quotaErrorCallbacks.js");async function o(){for(const r of e.quotaErrorCallbacks)await r()}require("../_version.js");
},{"../_private/logger.js":"RSRA","../models/quotaErrorCallbacks.js":"RaTe","../_version.js":"kCX8"}],"dATt":[function(require,module,exports) {
"use strict";function e(e){return new Promise(t=>setTimeout(t,e))}Object.defineProperty(exports,"__esModule",{value:!0}),exports.timeout=e,require("../_version.js");
},{"../_version.js":"kCX8"}],"g6Ca":[function(require,module,exports) {
"use strict";try{self["workbox:strategies:6.1.2"]&&_()}catch(t){}
},{}],"VmpW":[function(require,module,exports) {
"use strict";Object.defineProperty(exports,"__esModule",{value:!0}),exports.StrategyHandler=void 0;var e=require("workbox-core/_private/assert.js"),t=require("workbox-core/_private/cacheMatchIgnoreParams.js"),a=require("workbox-core/_private/Deferred.js"),r=require("workbox-core/_private/executeQuotaErrorCallbacks.js"),s=require("workbox-core/_private/getFriendlyURL.js"),i=require("workbox-core/_private/logger.js"),o=require("workbox-core/_private/timeout.js"),c=require("workbox-core/_private/WorkboxError.js");function n(e){return"string"==typeof e?new Request(e):e}require("./_version.js");class h{constructor(e,t){this._cacheKeys={},Object.assign(this,t),this.event=t.event,this._strategy=e,this._handlerDeferred=new a.Deferred,this._extendLifetimePromises=[],this._plugins=[...e.plugins],this._pluginStateMap=new Map;for(const a of this._plugins)this._pluginStateMap.set(a,{});this.event.waitUntil(this._handlerDeferred.promise)}async fetch(e){const{event:t}=this;let a=n(e);if("navigate"===a.mode&&t instanceof FetchEvent&&t.preloadResponse){const e=await t.preloadResponse;if(e)return e}const r=this.hasCallback("fetchDidFail")?a.clone():null;try{for(const e of this.iterateCallbacks("requestWillFetch"))a=await e({request:a.clone(),event:t})}catch(i){throw new c.WorkboxError("plugin-error-request-will-fetch",{thrownError:i})}const s=a.clone();try{let e;e=await fetch(a,"navigate"===a.mode?void 0:this._strategy.fetchOptions);for(const a of this.iterateCallbacks("fetchDidSucceed"))e=await a({event:t,request:s,response:e});return e}catch(o){throw r&&await this.runCallbacks("fetchDidFail",{error:o,event:t,originalRequest:r.clone(),request:s.clone()}),o}}async fetchAndCachePut(e){const t=await this.fetch(e),a=t.clone();return this.waitUntil(this.cachePut(e,a)),t}async cacheMatch(e){const t=n(e);let a;const{cacheName:r,matchOptions:s}=this._strategy,i=await this.getCacheKey(t,"read"),o={...s,cacheName:r};a=await caches.match(i,o);for(const c of this.iterateCallbacks("cachedResponseWillBeUsed"))a=await c({cacheName:r,matchOptions:s,cachedResponse:a,request:i,event:this.event})||void 0;return a}async cachePut(e,a){const i=n(e);await(0,o.timeout)(0);const h=await this.getCacheKey(i,"write");if(!a)throw new c.WorkboxError("cache-put-with-no-response",{url:(0,s.getFriendlyURL)(h.url)});const l=await this._ensureResponseSafeToCache(a);if(!l)return!1;const{cacheName:u,matchOptions:f}=this._strategy,p=await self.caches.open(u),d=this.hasCallback("cacheDidUpdate"),w=d?await(0,t.cacheMatchIgnoreParams)(p,h.clone(),["__WB_REVISION__"],f):null;try{await p.put(h,d?l.clone():l)}catch(_){throw"QuotaExceededError"===_.name&&await(0,r.executeQuotaErrorCallbacks)(),_}for(const t of this.iterateCallbacks("cacheDidUpdate"))await t({cacheName:u,oldResponse:w,newResponse:l.clone(),request:h,event:this.event});return!0}async getCacheKey(e,t){if(!this._cacheKeys[t]){let a=e;for(const e of this.iterateCallbacks("cacheKeyWillBeUsed"))a=n(await e({mode:t,request:a,event:this.event,params:this.params}));this._cacheKeys[t]=a}return this._cacheKeys[t]}hasCallback(e){for(const t of this._strategy.plugins)if(e in t)return!0;return!1}async runCallbacks(e,t){for(const a of this.iterateCallbacks(e))await a(t)}*iterateCallbacks(e){for(const t of this._strategy.plugins)if("function"==typeof t[e]){const a=this._pluginStateMap.get(t),r=r=>{const s={...r,state:a};return t[e](s)};yield r}}waitUntil(e){return this._extendLifetimePromises.push(e),e}async doneWaiting(){let e;for(;e=this._extendLifetimePromises.shift();)await e}destroy(){this._handlerDeferred.resolve()}async _ensureResponseSafeToCache(e){let t=e,a=!1;for(const r of this.iterateCallbacks("cacheWillUpdate"))if(a=!0,!(t=await r({request:this.request,response:t,event:this.event})||void 0))break;return a||t&&200!==t.status&&(t=void 0),t}}exports.StrategyHandler=h;
},{"workbox-core/_private/assert.js":"fLQu","workbox-core/_private/cacheMatchIgnoreParams.js":"fCxI","workbox-core/_private/Deferred.js":"KCEd","workbox-core/_private/executeQuotaErrorCallbacks.js":"nHsh","workbox-core/_private/getFriendlyURL.js":"ATI6","workbox-core/_private/logger.js":"RSRA","workbox-core/_private/timeout.js":"dATt","workbox-core/_private/WorkboxError.js":"sMOR","./_version.js":"g6Ca"}],"AZ0B":[function(require,module,exports) {
"use strict";Object.defineProperty(exports,"__esModule",{value:!0}),exports.Strategy=void 0;var e=require("workbox-core/_private/cacheNames.js"),r=require("workbox-core/_private/WorkboxError.js"),t=require("workbox-core/_private/logger.js"),a=require("workbox-core/_private/getFriendlyURL.js"),s=require("./StrategyHandler.js");require("./_version.js");class o{constructor(r={}){this.cacheName=e.cacheNames.getRuntimeName(r.cacheName),this.plugins=r.plugins||[],this.fetchOptions=r.fetchOptions,this.matchOptions=r.matchOptions}handle(e){const[r]=this.handleAll(e);return r}handleAll(e){e instanceof FetchEvent&&(e={event:e,request:e.request});const r=e.event,t="string"==typeof e.request?new Request(e.request):e.request,a="params"in e?e.params:void 0,o=new s.StrategyHandler(this,{event:r,request:t,params:a}),n=this._getResponse(o,t,r);return[n,this._awaitComplete(n,o,t,r)]}async _getResponse(e,t,a){await e.runCallbacks("handlerWillStart",{event:a,request:t});let s=void 0;try{if(!(s=await this._handle(t,e))||"error"===s.type)throw new r.WorkboxError("no-response",{url:t.url})}catch(o){for(const r of e.iterateCallbacks("handlerDidError"))if(s=await r({error:o,event:a,request:t}))break;if(!s)throw o}for(const r of e.iterateCallbacks("handlerWillRespond"))s=await r({event:a,request:t,response:s});return s}async _awaitComplete(e,r,t,a){let s,o;try{s=await e}catch(o){}try{await r.runCallbacks("handlerDidRespond",{event:a,request:t,response:s}),await r.doneWaiting()}catch(n){o=n}if(await r.runCallbacks("handlerDidComplete",{event:a,request:t,response:s,error:o}),r.destroy(),o)throw o}}exports.Strategy=o;
},{"workbox-core/_private/cacheNames.js":"UOvG","workbox-core/_private/WorkboxError.js":"sMOR","workbox-core/_private/logger.js":"RSRA","workbox-core/_private/getFriendlyURL.js":"ATI6","./StrategyHandler.js":"VmpW","./_version.js":"g6Ca"}],"JoVB":[function(require,module,exports) {
"use strict";Object.defineProperty(exports,"__esModule",{value:!0}),exports.messages=void 0;var e=require("workbox-core/_private/logger.js"),r=require("workbox-core/_private/getFriendlyURL.js");require("../_version.js");const o={strategyStart:(e,o)=>`Using ${e} to respond to '${(0,r.getFriendlyURL)(o.url)}'`,printFinalResponse:r=>{r&&(e.logger.groupCollapsed("View the final response here."),e.logger.log(r||"[No response returned]"),e.logger.groupEnd())}};exports.messages=o;
},{"workbox-core/_private/logger.js":"RSRA","workbox-core/_private/getFriendlyURL.js":"ATI6","../_version.js":"g6Ca"}],"Cvkc":[function(require,module,exports) {
"use strict";Object.defineProperty(exports,"__esModule",{value:!0}),exports.CacheFirst=void 0;var r=require("workbox-core/_private/assert.js"),e=require("workbox-core/_private/logger.js"),t=require("workbox-core/_private/WorkboxError.js"),s=require("./Strategy.js"),o=require("./utils/messages.js");require("./_version.js");class a extends s.Strategy{async _handle(r,e){let s,o=await e.cacheMatch(r);if(o)0;else{0;try{o=await e.fetchAndCachePut(r)}catch(a){s=a}0}if(!o)throw new t.WorkboxError("no-response",{url:r.url,error:s});return o}}exports.CacheFirst=a;
},{"workbox-core/_private/assert.js":"fLQu","workbox-core/_private/logger.js":"RSRA","workbox-core/_private/WorkboxError.js":"sMOR","./Strategy.js":"AZ0B","./utils/messages.js":"JoVB","./_version.js":"g6Ca"}],"vA9i":[function(require,module,exports) {
"use strict";Object.defineProperty(exports,"__esModule",{value:!0}),exports.CacheOnly=void 0;var r=require("workbox-core/_private/assert.js"),e=require("workbox-core/_private/logger.js"),o=require("workbox-core/_private/WorkboxError.js"),s=require("./Strategy.js"),t=require("./utils/messages.js");require("./_version.js");class a extends s.Strategy{async _handle(r,e){const s=await e.cacheMatch(r);if(!s)throw new o.WorkboxError("no-response",{url:r.url});return s}}exports.CacheOnly=a;
},{"workbox-core/_private/assert.js":"fLQu","workbox-core/_private/logger.js":"RSRA","workbox-core/_private/WorkboxError.js":"sMOR","./Strategy.js":"AZ0B","./utils/messages.js":"JoVB","./_version.js":"g6Ca"}],"dueY":[function(require,module,exports) {
"use strict";Object.defineProperty(exports,"__esModule",{value:!0}),exports.cacheOkAndOpaquePlugin=void 0,require("../_version.js");const e={cacheWillUpdate:async({response:e})=>200===e.status||0===e.status?e:null};exports.cacheOkAndOpaquePlugin=e;
},{"../_version.js":"g6Ca"}],"vUSX":[function(require,module,exports) {
"use strict";Object.defineProperty(exports,"__esModule",{value:!0}),exports.NetworkFirst=void 0;var e=require("workbox-core/_private/assert.js"),t=require("workbox-core/_private/logger.js"),r=require("workbox-core/_private/WorkboxError.js"),s=require("./plugins/cacheOkAndOpaquePlugin.js"),o=require("./Strategy.js"),i=require("./utils/messages.js");require("./_version.js");class a extends o.Strategy{constructor(e={}){super(e),this.plugins.some(e=>"cacheWillUpdate"in e)||this.plugins.unshift(s.cacheOkAndOpaquePlugin),this._networkTimeoutSeconds=e.networkTimeoutSeconds||0}async _handle(e,t){const s=[];const o=[];let i;if(this._networkTimeoutSeconds){const{id:r,promise:a}=this._getTimeoutPromise({request:e,logs:s,handler:t});i=r,o.push(a)}const a=this._getNetworkPromise({timeoutId:i,request:e,logs:s,handler:t});o.push(a);const n=await t.waitUntil((async()=>await t.waitUntil(Promise.race(o))||await a)());if(!n)throw new r.WorkboxError("no-response",{url:e.url});return n}_getTimeoutPromise({request:e,logs:t,handler:r}){let s;return{promise:new Promise(t=>{s=setTimeout(async()=>{t(await r.cacheMatch(e))},1e3*this._networkTimeoutSeconds)}),id:s}}async _getNetworkPromise({timeoutId:e,request:t,logs:r,handler:s}){let o,i;try{i=await s.fetchAndCachePut(t)}catch(a){o=a}return e&&clearTimeout(e),!o&&i||(i=await s.cacheMatch(t)),i}}exports.NetworkFirst=a;
},{"workbox-core/_private/assert.js":"fLQu","workbox-core/_private/logger.js":"RSRA","workbox-core/_private/WorkboxError.js":"sMOR","./plugins/cacheOkAndOpaquePlugin.js":"dueY","./Strategy.js":"AZ0B","./utils/messages.js":"JoVB","./_version.js":"g6Ca"}],"F0eM":[function(require,module,exports) {
"use strict";Object.defineProperty(exports,"__esModule",{value:!0}),exports.NetworkOnly=void 0;var e=require("workbox-core/_private/assert.js"),r=require("workbox-core/_private/logger.js"),o=require("workbox-core/_private/timeout.js"),t=require("workbox-core/_private/WorkboxError.js"),s=require("./Strategy.js"),i=require("./utils/messages.js");require("./_version.js");class n extends s.Strategy{constructor(e={}){super(e),this._networkTimeoutSeconds=e.networkTimeoutSeconds||0}async _handle(e,r){let s,i=void 0;try{const t=[r.fetch(e)];if(this._networkTimeoutSeconds){const e=(0,o.timeout)(1e3*this._networkTimeoutSeconds);t.push(e)}if(!(s=await Promise.race(t)))throw new Error("Timed out the network response after "+`${this._networkTimeoutSeconds} seconds.`)}catch(n){i=n}if(!s)throw new t.WorkboxError("no-response",{url:e.url,error:i});return s}}exports.NetworkOnly=n;
},{"workbox-core/_private/assert.js":"fLQu","workbox-core/_private/logger.js":"RSRA","workbox-core/_private/timeout.js":"dATt","workbox-core/_private/WorkboxError.js":"sMOR","./Strategy.js":"AZ0B","./utils/messages.js":"JoVB","./_version.js":"g6Ca"}],"LESc":[function(require,module,exports) {
"use strict";Object.defineProperty(exports,"__esModule",{value:!0}),exports.StaleWhileRevalidate=void 0;var e=require("workbox-core/_private/assert.js"),r=require("workbox-core/_private/logger.js"),t=require("workbox-core/_private/WorkboxError.js"),s=require("./plugins/cacheOkAndOpaquePlugin.js"),a=require("./Strategy.js"),i=require("./utils/messages.js");require("./_version.js");class o extends a.Strategy{constructor(e){super(e),this.plugins.some(e=>"cacheWillUpdate"in e)||this.plugins.unshift(s.cacheOkAndOpaquePlugin)}async _handle(e,r){const s=r.fetchAndCachePut(e).catch(()=>{});let a,i=await r.cacheMatch(e);if(i)0;else{0;try{i=await s}catch(o){a=o}}if(!i)throw new t.WorkboxError("no-response",{url:e.url,error:a});return i}}exports.StaleWhileRevalidate=o;
},{"workbox-core/_private/assert.js":"fLQu","workbox-core/_private/logger.js":"RSRA","workbox-core/_private/WorkboxError.js":"sMOR","./plugins/cacheOkAndOpaquePlugin.js":"dueY","./Strategy.js":"AZ0B","./utils/messages.js":"JoVB","./_version.js":"g6Ca"}],"wORm":[function(require,module,exports) {
"use strict";Object.defineProperty(exports,"__esModule",{value:!0}),Object.defineProperty(exports,"CacheFirst",{enumerable:!0,get:function(){return e.CacheFirst}}),Object.defineProperty(exports,"CacheOnly",{enumerable:!0,get:function(){return r.CacheOnly}}),Object.defineProperty(exports,"NetworkFirst",{enumerable:!0,get:function(){return t.NetworkFirst}}),Object.defineProperty(exports,"NetworkOnly",{enumerable:!0,get:function(){return n.NetworkOnly}}),Object.defineProperty(exports,"StaleWhileRevalidate",{enumerable:!0,get:function(){return i.StaleWhileRevalidate}}),Object.defineProperty(exports,"Strategy",{enumerable:!0,get:function(){return a.Strategy}}),Object.defineProperty(exports,"StrategyHandler",{enumerable:!0,get:function(){return u.StrategyHandler}});var e=require("./CacheFirst.js"),r=require("./CacheOnly.js"),t=require("./NetworkFirst.js"),n=require("./NetworkOnly.js"),i=require("./StaleWhileRevalidate.js"),a=require("./Strategy.js"),u=require("./StrategyHandler.js");require("./_version.js");
},{"./CacheFirst.js":"Cvkc","./CacheOnly.js":"vA9i","./NetworkFirst.js":"vUSX","./NetworkOnly.js":"F0eM","./StaleWhileRevalidate.js":"LESc","./Strategy.js":"AZ0B","./StrategyHandler.js":"VmpW","./_version.js":"g6Ca"}],"XVv1":[function(require,module,exports) {
"use strict";Object.defineProperty(exports,"__esModule",{value:!0});var e=require("./index.js");Object.keys(e).forEach(function(r){"default"!==r&&"__esModule"!==r&&(r in exports&&exports[r]===e[r]||Object.defineProperty(exports,r,{enumerable:!0,get:function(){return e[r]}}))});
},{"./index.js":"wORm"}],"AaGI":[function(require,module,exports) {
"use strict";var e=require("workbox-routing"),r=require("workbox-strategies");(0,e.registerRoute)(function(e){return"https://pokeapi.co"===e.url.origin},new r.CacheFirst({cacheName:"pokeapi-cache"}));
},{"workbox-routing":"JU0p","workbox-strategies":"XVv1"}]},{},["AaGI"], null)
//# sourceMappingURL=service-worker.js.map