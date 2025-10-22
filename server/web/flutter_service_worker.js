'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"main.dart.js": "87649876a981db6f691938aa5ddb528c",
"main.dart.js_98.part.js": "610db2ce40fd15b827c0488c9a9e31be",
"main.dart.js_66.part.js": "cb66bc629d11ab42d625f5db5f1f4fe4",
"main.dart.js_63.part.js": "8954c8a3cdc60d105e20a8b0291351e9",
"main.dart.js_32.part.js": "50110554f2dde357a6e7508ca290794b",
"main.dart.js_75.part.js": "fb11b5c1e8ffe07d2979c52fa99f4637",
"main.dart.js_9.part.js": "06f8eb03d971c1b0ccecfbd2d569626e",
"flutter_bootstrap.js": "fc8a4bdfe5b2906d93b2fa13f61f6c07",
"main.dart.js_61.part.js": "a51c47f8feed7841bae1585f12457952",
"main.dart.js_64.part.js": "9f4c5c70c06aec73b686f6356b67ebbc",
"main.dart.js_60.part.js": "4399811eb1725a70fd5b9b2d69c28de7",
"main.dart.js_102.part.js": "9776ed40aa4410e8891b8d6868bf71b5",
"main.dart.js_76.part.js": "8a2b228f4ba21dfdf6f70cb004724937",
"main.dart.js_106.part.js": "82560090a5cd712805db0805df334b19",
"main.dart.js_62.part.js": "230eb914c8949ff81938f346d555f862",
"main.dart.js_68.part.js": "f4a73ada37f8cec200117ca9c21f4f9b",
"main.dart.js_83.part.js": "0f7632004eaad05340add02921affad4",
"canvaskit/canvaskit.js.symbols": "bdcd3835edf8586b6d6edfce8749fb77",
"canvaskit/canvaskit.wasm": "7a3f4ae7d65fc1de6a6e7ddd3224bc93",
"canvaskit/chromium/canvaskit.js.symbols": "b61b5f4673c9698029fa0a746a9ad581",
"canvaskit/chromium/canvaskit.wasm": "f504de372e31c8031018a9ec0a9ef5f0",
"canvaskit/chromium/canvaskit.js": "8191e843020c832c9cf8852a4b909d4c",
"canvaskit/skwasm.wasm": "39dd80367a4e71582d234948adc521c0",
"canvaskit/skwasm.js.symbols": "e72c79950c8a8483d826a7f0560573a1",
"canvaskit/canvaskit.js": "728b2d477d9b8c14593d4f9b82b484f3",
"canvaskit/skwasm.js": "ea559890a088fe28b4ddf70e17e60052",
"main.dart.js_79.part.js": "e061d1b83078af566094232b21f88a5f",
"main.dart.js_71.part.js": "77744b05bd9b0f1d14f7efea91e9a804",
"main.dart.js_41.part.js": "9ef7a16d33edf5e684918d84d1041378",
"main.dart.js_50.part.js": "6e76516f5afdb7eca5d97013fbe13f20",
"main.dart.js_40.part.js": "eef0bcf4151db3708f681725b0e10017",
"main.dart.js_113.part.js": "172ea46a7b263ba6b1de0509c710fab6",
"main.dart.js_101.part.js": "468db9acb41b53790bf73f50d40e9f27",
"main.dart.js_30.part.js": "f8ce130cbec5ace4aae77cca5778fffd",
"main.dart.js_128.part.js": "f401c140875f74a9d51b2fb53b47cf25",
"main.dart.js_51.part.js": "192264ac689bd7070baf8eebeca92fdd",
"main.dart.js_28.part.js": "7c908c0e529c6fc3eeff58c3f003682a",
"main.dart.js_29.part.js": "2e5cfdf6007ef6a1687a30c6a7d13cb7",
"main.dart.js_7.part.js": "91896706527aefccf311996167e42781",
"main.dart.js_91.part.js": "cbeb45c8bb10e557d2eb9ff14ac2821b",
"main.dart.js_8.part.js": "501ffa678a07240640e7088f83797162",
"main.dart.js_25.part.js": "97be0a1b343ca67d330614ce0ca9fa95",
"main.dart.js_103.part.js": "21c474d3e5074381166e1089cf52ce73",
"main.dart.js_1.part.js": "180bfe0afd956808f74a552c1a8075cc",
"main.dart.js_3.part.js": "13312b14415aa0fb90d4584b0ed02011",
"main.dart.js_34.part.js": "d7fba9cf2117c4302028f769836c1bb6",
"main.dart.js_126.part.js": "06465f7fbbd55556fa80422ab2b78945",
"main.dart.js_22.part.js": "041bb8929a684b53446b1ca57d0a8207",
"main.dart.js_130.part.js": "c50475874ada8288582e6a05753c35fb",
"main.dart.js_14.part.js": "7b89d28dd265ef33d9b3e6942aad6d9e",
"main.dart.js_49.part.js": "05a690e5eee35ac91673599e13f2c08b",
"main.dart.js_20.part.js": "9cca7b4ed56a9156f9ede55fe6a8aacf",
"main.dart.js_118.part.js": "7da10686fdd959fae07f2e52d3c56614",
"main.dart.js_105.part.js": "623678729dea6340ab466b4b6b674fb0",
"main.dart.js_6.part.js": "edb497da7023470dc45cb4c9ada1d1b2",
"main.dart.js_87.part.js": "2217647d3a2d6b174e06b516cd253225",
"main.dart.js_46.part.js": "4cee0815a1ac395fd55fc21e5739cb11",
"main.dart.js_16.part.js": "93da56417edd5d959a26ba3efbfcbdea",
"main.dart.js_5.part.js": "4dac6ffd13cd262b88e9ac5616e34b10",
"main.dart.js_57.part.js": "817c507df8f8184ea7f5111384f49d4b",
"main.dart.js_82.part.js": "da178e89354386514a31c03541fe14ce",
"main.dart.js_17.part.js": "19a504903625cff60efc4a8832874c68",
"main.dart.js_36.part.js": "376da599e91c15731bc954802b80bfd2",
"main.dart.js_15.part.js": "9ae7325996ac84832dc4825c96f43e9a",
"main.dart.js_31.part.js": "38709d204c8e53ff8b00cec0ab715888",
"main.dart.js_21.part.js": "5958ccfea86eca6f62d47273f24af06b",
"main.dart.js_10.part.js": "ed1242879a1c1fa9d82ed14e4172579f",
"main.dart.js_73.part.js": "e8919efdd4e291311715f35e2b2e9d97",
"main.dart.js_93.part.js": "b00290a9258e20c5049d26df1f912f1e",
"main.dart.js_115.part.js": "0c55c09f9037f291d2d71780a2582daa",
"main.dart.js_119.part.js": "c53350ae5bcfb4d63cc510b042359af9",
"main.dart.js_54.part.js": "7d79c421ed54bced7f7e7083f234572d",
"main.dart.js_123.part.js": "8f7907b1bdaa78c2e54cdaf31db2cfcb",
"main.dart.js_38.part.js": "11317ec48c02c61b487148ef162a0fcf",
"main.dart.js_117.part.js": "55bf5e9c8b8bb86d252787024f343fb8",
"main.dart.js_116.part.js": "4ceb46488b503d4cad3e50e64a661da7",
"main.dart.js_74.part.js": "7a6601c8bdbe7fc388b9755b327eb869",
"main.dart.js_125.part.js": "c68e34187da97c7b3352f790df12bb34",
"main.dart.js_53.part.js": "de7e8ed42998280e5305ce4757bba430",
"main.dart.js_96.part.js": "03f49bf8ddddbd02bf1f98bbf764a34b",
"main.dart.js_81.part.js": "0a0ef3a2666d9aee677178c1f2d6a413",
"main.dart.js_19.part.js": "dd212b90715db30321520db397e3072a",
"main.dart.js_18.part.js": "aa9b10ae9f7dd6ac6bf90e7fea191284",
"main.dart.js_84.part.js": "71128b0d131bfa89f1c59c5ebc25caf5",
"main.dart.js_129.part.js": "a11655c8ad6f2d5aa658b20f8d172485",
"main.dart.js_42.part.js": "5c5dd7b91c39e57b402bcb8733c2f87f",
"main.dart.js_55.part.js": "6c422112b08d4f17bf87460915f17e84",
"main.dart.js_107.part.js": "80cce55b29f7ab93e5c87c11aa8f2be6",
"main.dart.js_44.part.js": "9d5d4a4f5a096298f25a75c776109c63",
"main.dart.js_65.part.js": "7e62bf05f4b21941191608cfcc89d835",
"main.dart.js_72.part.js": "0b662070fa169d9a5dd84cf341f644cf",
"icons/Icon-maskable-512.png": "274a1e917760a1f046d666e6202d023a",
"icons/Icon-maskable-96.png": "91ebf99f57762a0a291d74ca8992d18c",
"icons/Icon-maskable-128.png": "246028210ed2ad790833d9bae1456df3",
"icons/Icon-192.png": "de2ec02df3a1869af4ad786b508d58d0",
"icons/Icon-maskable-192.png": "0bf4a53e4bdef76509c1639561988a14",
"icons/Icon-512.png": "80a96cdf564eb56bf72144a81d528408",
"main.dart.js_77.part.js": "f6a3f32088213294f66338eed5cff96b",
"main.dart.js_85.part.js": "03e9046d8d352217e593cf2cf57794f8",
"main.dart.js_108.part.js": "d9f9e5964c6e1bca3d5542373e991e62",
"main.dart.js_59.part.js": "77a60d2c8bc48994af66b9975b8aaaeb",
"main.dart.js_94.part.js": "148235ddcde22bc8cfbc8539d8dbf9dc",
"main.dart.js_89.part.js": "f4a17b4029cb68b7303ef4b5e0d0868d",
"main.dart.js_70.part.js": "1abe4b728e4593778e5b07c9101c85d1",
"main.dart.js_33.part.js": "42217f185899bfd759df7f2f375a59b5",
"flutter.js": "83d881c1dbb6d6bcd6b42e274605b69c",
"main.dart.js_58.part.js": "67ed9c7ec09d0a06ca26305a1e5a5179",
"main.dart.js_24.part.js": "c9fd8eaccab029c6df97a2096f563d5d",
"main.dart.js_48.part.js": "0c960e90e7af0c6d83f733baf30c5dc8",
"main.dart.js_92.part.js": "d4e36c0b7a30a6e0e61fc6af687d09e2",
"main.dart.js_110.part.js": "50ddce77b241f51e0b27028fbb8bcb99",
"main.dart.js_104.part.js": "d99b2d74872faaf5afafb828b79ace0b",
"main.dart.js_11.part.js": "b319c12d4bc6f0fc73502d1cce19e9ad",
"main.dart.js_124.part.js": "59aced1c1b2aa4adc9adcbc1a55f54ab",
"index.html": "82b2b56fc1dbb6c967c1c5e00bbb3ac7",
"/": "82b2b56fc1dbb6c967c1c5e00bbb3ac7",
"main.dart.js_4.part.js": "e914338f60265d60cc38193955dc446a",
"main.dart.js_97.part.js": "f1a45713b6aaeba2d2b233e87d715b39",
"main.dart.js_26.part.js": "97b67672c53b148dff6c0ee545e513f8",
"main.dart.js_47.part.js": "516da692e0b6c3c824cbf8ccc27a5591",
"main.dart.js_127.part.js": "0403becc70aae16f9d4073197bffa811",
"main.dart.js_37.part.js": "1421b877ef55ee08d0e20d158a4aeaf4",
"main.dart.js_27.part.js": "83eaabafb619f3dfe95866fd36b260d7",
"main.dart.js_99.part.js": "8d316622c454f83565d6a58df4ea03c0",
"main.dart.js_13.part.js": "1882a89562dd425b22bf0fa20efab83a",
"main.dart.js_112.part.js": "c527fcfe712da70d9a92ece3503f5f5f",
"main.dart.js_43.part.js": "78a0878f86fde4016849902c7070e0da",
"main.dart.js_39.part.js": "7015341dd4a2d3a7067430713834d803",
"assets/AssetManifest.bin": "eb9126b4e5ae49971137bb64d6cff5f3",
"assets/cargoship/iconttf/RpgAwesome.ttf": "3fb8d0aa42860e8db819f5d3c65834c5",
"assets/cargoship/builtin_fonts/Palatino_bold.ttf": "975972a205fd91a532d1b7433281af70",
"assets/cargoship/builtin_fonts/Palatino_italic.ttf": "be4590eba976dace111b6686f6dade52",
"assets/cargoship/builtin_fonts/Rubik-VariableFont_wght.ttf": "6d3102fa33194bef395536d580f91b56",
"assets/cargoship/builtin_fonts/Palatino_roman.ttf": "96261bb90c9babbf8042ce7f43200d65",
"assets/cargoship/builtin_fonts/Palatino_bolditalic.ttf": "beef66370e7124eb683514ad9ad07576",
"assets/AssetManifest.bin.json": "3ef8031b6c1baa93e3f709a6f2cdfdad",
"assets/fonts/MaterialIcons-Regular.otf": "f96211e53e534c1356645921a1704b8a",
"assets/FontManifest.json": "5bf5570bf3efc7b2862937a369b1b0df",
"assets/AssetManifest.json": "e4dae148b301d722c5fc55a227712fab",
"assets/packages/material_symbols_icons/lib/fonts/MaterialSymbolsSharp.ttf": "e949713f8bb3a755d44ac95a5a424214",
"assets/packages/material_symbols_icons/lib/fonts/MaterialSymbolsOutlined.ttf": "1b84da84f226780a46c68d94266ecf36",
"assets/packages/material_symbols_icons/lib/fonts/MaterialSymbolsRounded.ttf": "42f8e09d6b8e90f59fd663a0b53f58e5",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/shaders/water_clouds.frag": "704f028da22dcab33db2ddda3180ca43",
"assets/NOTICES": "4285cfd938c0dbf845be004aa6c43218",
"main.dart.js_88.part.js": "34c97effc166603890b2bc3bea7999ab",
"main.dart.js_120.part.js": "453a5b772da93aa95d5ba644b71a4451",
"main.dart.js_23.part.js": "760f8dc434ddeb76e37751f5cb59e29e",
"main.dart.js_121.part.js": "986e2327acbadd0e45868e77b18c586f",
"main.dart.js_67.part.js": "9ba0659b29c7c9fe98701ad8a9364930",
"main.dart.js_111.part.js": "cbcd8cc6b9928b3e09585f7a1e587d9d",
"main.dart.js_114.part.js": "e28dce683bde3faca13758c090b7bb7f",
"main.dart.js_122.part.js": "0f702a5bbda0065c5fdaad09d954a8b4",
"main.dart.js_69.part.js": "2e749b2602fa75b2c0198faf2a5d1ac5",
"main.dart.js_100.part.js": "fcb3bafb11775f4ca5161cf0090ab889",
"manifest.json": "38212b39dd51df343b19bfa938e9ac4f",
"main.dart.js_78.part.js": "f91c7cbf05b082d6fce6dad5d4e25e97",
"main.dart.js_90.part.js": "be525ac66384fd5da79d395a7d1a4667",
"main.dart.js_35.part.js": "dea0cdc728e641cb6e26b47997232ae9",
"main.dart.js_52.part.js": "113d840d0436acad5fdaae68a83f9ad9",
"main.dart.js_95.part.js": "9343c161355cc7bb761679eaa60c661a",
"version.json": "6b8b9140b83c40f85633ddfcd9f81cd7",
"main.dart.js_109.part.js": "6048ba429a6be2322389614569fbf933",
"main.dart.js_2.part.js": "2b8be0012aee06110338f769169e6d04",
"favicon.png": "306e7ba8f0872a8ae25be6aca7d80b7f",
"main.dart.js_45.part.js": "9ed8ec3e8bbdfa54cdfdf26ee9d17e29",
"main.dart.js_56.part.js": "e3a0553c8d69eb13680d20382d01de5e",
"main.dart.js_80.part.js": "38f5457f385085d29f25086edce39db2",
"main.dart.js_86.part.js": "f91816b11483968cfc47303fceb601c8",
"main.dart.js_12.part.js": "4414f10d76ea2b58acd22efa3d2f55d3"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
