'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"main.dart.js": "5c7be1e34f9956d9c45a9c0c5a209bd6",
"main.dart.js_98.part.js": "2367a24f7299a7ec54a2709f308173b9",
"main.dart.js_66.part.js": "104089aa2c08dda834689f1a98e53a5c",
"main.dart.js_63.part.js": "13fe7d15ccbc4babb92fb9b51b7ff94e",
"main.dart.js_32.part.js": "d91291041ef543f5a626f54e02581ca9",
"main.dart.js_75.part.js": "787d0c416f88be435e0a40fbe676b3fa",
"main.dart.js_9.part.js": "acc510b55d561b74818eda55e93554f6",
"flutter_bootstrap.js": "a7798da56002ebde83cab55c2463e098",
"main.dart.js_61.part.js": "636bf45680d06428a9f186c53c3821b5",
"main.dart.js_64.part.js": "a9ca70c9b3b3c32899bf4fe44a05e1fd",
"main.dart.js_60.part.js": "7af6bd9ecef1aafd06ea826a72e1bce2",
"main.dart.js_102.part.js": "a1e95dd6001a53e361070a8ab812988b",
"main.dart.js_76.part.js": "7dbedf628e623e3f73ef3acc42bd92fb",
"main.dart.js_106.part.js": "242365964979a9bd7b2172fa07ff4238",
"main.dart.js_62.part.js": "3ace3580140897e1ac3a3f3e62bc68bc",
"main.dart.js_68.part.js": "782f2f03947d7ae96ac9474c893b4967",
"main.dart.js_83.part.js": "c06b6c2567a51ce40d626634faba443f",
"canvaskit/canvaskit.js.symbols": "bdcd3835edf8586b6d6edfce8749fb77",
"canvaskit/canvaskit.wasm": "7a3f4ae7d65fc1de6a6e7ddd3224bc93",
"canvaskit/chromium/canvaskit.js.symbols": "b61b5f4673c9698029fa0a746a9ad581",
"canvaskit/chromium/canvaskit.wasm": "f504de372e31c8031018a9ec0a9ef5f0",
"canvaskit/chromium/canvaskit.js": "8191e843020c832c9cf8852a4b909d4c",
"canvaskit/skwasm.wasm": "39dd80367a4e71582d234948adc521c0",
"canvaskit/skwasm.js.symbols": "e72c79950c8a8483d826a7f0560573a1",
"canvaskit/canvaskit.js": "728b2d477d9b8c14593d4f9b82b484f3",
"canvaskit/skwasm.js": "ea559890a088fe28b4ddf70e17e60052",
"main.dart.js_79.part.js": "f481b68cbb21507a6f8d7ba891819a25",
"main.dart.js_71.part.js": "d6da6931582e55db2a88e9e0757b7259",
"main.dart.js_41.part.js": "6e83cba65784da1a401cb58b56ff0b5c",
"main.dart.js_50.part.js": "180d7f0be418e2daa6e44713264f1198",
"main.dart.js_40.part.js": "91a07c78db526563cb759921a06d565f",
"main.dart.js_113.part.js": "567d79e89870914ed4c718b1cbdcca8d",
"main.dart.js_101.part.js": "51075789643174e33919418727a114a1",
"main.dart.js_30.part.js": "ce25f27404bf1bac3a14e38840465f0a",
"main.dart.js_51.part.js": "961fc86c55e18c73af4c5e59558a3afb",
"main.dart.js_28.part.js": "7c908c0e529c6fc3eeff58c3f003682a",
"main.dart.js_29.part.js": "7c023a47fa597de717b6def939f25d18",
"main.dart.js_7.part.js": "710022106742610f39cadef3077189b7",
"main.dart.js_91.part.js": "e8be3dd573bdcce856c130b3d60b1d08",
"main.dart.js_8.part.js": "501ffa678a07240640e7088f83797162",
"main.dart.js_25.part.js": "83650dbcf75330d1c61d3522451ee43a",
"main.dart.js_103.part.js": "77ae5f42b91c2434c3b4134a40c32e2e",
"main.dart.js_1.part.js": "3f9da7c067553dbf647c460c0891070a",
"main.dart.js_3.part.js": "21725b287418cbb158ef97b78e566e88",
"main.dart.js_34.part.js": "7aa57e126a01f03ad43b789e9c6d8b50",
"main.dart.js_22.part.js": "041bb8929a684b53446b1ca57d0a8207",
"main.dart.js_14.part.js": "2d22b95cfafbeb677517b59ce53f1ede",
"main.dart.js_49.part.js": "b2fa436680264c927d70d0623fd66d7f",
"main.dart.js_20.part.js": "89798d2a4dda7ffbd1737661469caf3e",
"main.dart.js_105.part.js": "34bffa52da9c284386b567aff8854190",
"main.dart.js_6.part.js": "b4c643f790963de3c9f94ce5f305a31a",
"main.dart.js_87.part.js": "28e82b6505c38b50dc8c04f3689060fd",
"main.dart.js_46.part.js": "5d8e0809176bbc3d98b5243d52fed31f",
"main.dart.js_16.part.js": "f01400a9d340b566cb6687bcbb0094cd",
"main.dart.js_5.part.js": "7268ab48d6ab52f52a916d246ad76b4c",
"main.dart.js_57.part.js": "685461be8bb484a024351edc32a6109e",
"main.dart.js_82.part.js": "561574a1617ba02f6f3268b528cfdc94",
"main.dart.js_17.part.js": "801f0e42a4e9a32421857c570eeff279",
"main.dart.js_36.part.js": "b1ceb4dcf43639ac9dfe687e67e1c6c7",
"main.dart.js_15.part.js": "a0310b5d74cc8f3201c2bbaff31f5b86",
"main.dart.js_31.part.js": "dfd15559eb45c68e1d4fa5cf10bb7bc4",
"main.dart.js_21.part.js": "5958ccfea86eca6f62d47273f24af06b",
"main.dart.js_10.part.js": "ee0d9c24c16e6748bf29be34d038d348",
"main.dart.js_73.part.js": "b772cdb029378f0cad962ebcc09963a4",
"main.dart.js_93.part.js": "2619a3210c537f5c63ee0897f49356fb",
"main.dart.js_115.part.js": "b07bb3c54c941cbb4e6cd3f744657b82",
"main.dart.js_54.part.js": "7d79c421ed54bced7f7e7083f234572d",
"main.dart.js_38.part.js": "5312596cca193b322654bfc8d5a4d59a",
"main.dart.js_117.part.js": "4ec43ea82bdfb87b07456e42b6e9dca4",
"main.dart.js_116.part.js": "b5543a72e04fda02a0824d91118a43e3",
"main.dart.js_74.part.js": "8f7a95880c35181f024f74e2d050f35c",
"main.dart.js_53.part.js": "1d761011883524e30b0dae6f6118bd32",
"main.dart.js_96.part.js": "16267acd29b07c4c25aeb4d262d578d9",
"main.dart.js_81.part.js": "7a3fddc2fadd96fbc25d8c30ab60c507",
"main.dart.js_19.part.js": "0a046bd2113c763c5110b24da6fcae5a",
"main.dart.js_18.part.js": "08b756bbd5fd6beb0b503386d1478c24",
"main.dart.js_84.part.js": "3a619a6daf4a8347db75a6d0757e68b5",
"main.dart.js_42.part.js": "3d6e13a0329a913efbe4bab36d8da291",
"main.dart.js_55.part.js": "c7c1c678e6f9fd80766aed45218f35f7",
"main.dart.js_107.part.js": "ed1e605e68600d5b093ba263d549e322",
"main.dart.js_44.part.js": "21c0139be7a7ae38ca6ec759aa9bf3d8",
"main.dart.js_65.part.js": "98e090f441a9d5da0e8927b5f7e6decf",
"main.dart.js_72.part.js": "58158b09fe158084fee38ae627f16bc8",
"icons/Icon-maskable-512.png": "274a1e917760a1f046d666e6202d023a",
"icons/Icon-maskable-96.png": "91ebf99f57762a0a291d74ca8992d18c",
"icons/Icon-maskable-128.png": "246028210ed2ad790833d9bae1456df3",
"icons/Icon-192.png": "de2ec02df3a1869af4ad786b508d58d0",
"icons/Icon-maskable-192.png": "0bf4a53e4bdef76509c1639561988a14",
"icons/Icon-512.png": "80a96cdf564eb56bf72144a81d528408",
"main.dart.js_77.part.js": "d5f7718cd4410207983dbebae9e0cb06",
"main.dart.js_85.part.js": "59129e780cf5586969d941ec2b827a5d",
"main.dart.js_108.part.js": "ee30349869dd97a8429ca785e7876ce7",
"main.dart.js_59.part.js": "7600be20ca5a69a0c34ff71415705741",
"main.dart.js_94.part.js": "09a26c5f2c07a1d968ed5403ba713cbb",
"main.dart.js_89.part.js": "726fdacdbd47e83b5ddd6d3157553081",
"main.dart.js_70.part.js": "0b1377c211463468c191951409b1b805",
"main.dart.js_33.part.js": "7d62776b1cb98b5408d061e88463ea00",
"flutter.js": "83d881c1dbb6d6bcd6b42e274605b69c",
"main.dart.js_58.part.js": "0949e4f8210ec7e43f5f8d8a1e88d4df",
"main.dart.js_24.part.js": "ca2f52f9e6aa8599bd177f2de4a393ed",
"main.dart.js_48.part.js": "dcd94877b35bb8943dcc849c808c6581",
"main.dart.js_92.part.js": "2d8895be1a2092f39c586a5522c4fc4a",
"main.dart.js_110.part.js": "b9957b90ce71300d73957b05ab129907",
"main.dart.js_104.part.js": "40d8a71e1bb9de42225e91f0ead70c6f",
"main.dart.js_11.part.js": "24045cf7df5862d536c32655c2800a5d",
"index.html": "3729d550786888bd12e96b5cf88dca4c",
"/": "3729d550786888bd12e96b5cf88dca4c",
"main.dart.js_4.part.js": "3cae833f7835a8f809dd3e061fa13835",
"main.dart.js_97.part.js": "cd2d91660e11bd21494b319d5ed6dab4",
"main.dart.js_26.part.js": "22328b602891b8cd958bfc0926a94209",
"main.dart.js_47.part.js": "a2938d2feb6e9cf79fa8aef6280f9b23",
"main.dart.js_37.part.js": "6d5a8c40111817f7408cd356ee458a8b",
"main.dart.js_27.part.js": "83eaabafb619f3dfe95866fd36b260d7",
"main.dart.js_99.part.js": "baa8ff33d386b1894fb3014b727003f3",
"main.dart.js_13.part.js": "b344ca03495b115a8c125ba579bec094",
"main.dart.js_112.part.js": "684ae6917a466a25eb43e2ed9520b07f",
"main.dart.js_43.part.js": "f432514fb9f786f3624a725ec4443c96",
"main.dart.js_39.part.js": "fe9067039c4f03e4700caa1d9cd6490b",
"assets/AssetManifest.bin": "15eb632a3e683ef327e8bd267cfad431",
"assets/cargoship/iconttf/RpgAwesome.ttf": "3fb8d0aa42860e8db819f5d3c65834c5",
"assets/cargoship/builtin_fonts/Palatino_bold.ttf": "975972a205fd91a532d1b7433281af70",
"assets/cargoship/builtin_fonts/Palatino_italic.ttf": "be4590eba976dace111b6686f6dade52",
"assets/cargoship/builtin_fonts/Rubik-VariableFont_wght.ttf": "6d3102fa33194bef395536d580f91b56",
"assets/cargoship/builtin_fonts/Palatino_roman.ttf": "96261bb90c9babbf8042ce7f43200d65",
"assets/cargoship/builtin_fonts/Palatino_bolditalic.ttf": "beef66370e7124eb683514ad9ad07576",
"assets/AssetManifest.bin.json": "0561832c02c3fbc11d7fc888a2332b94",
"assets/fonts/MaterialIcons-Regular.otf": "95cf3f9ef640d984b7ad8b17c787e1f9",
"assets/FontManifest.json": "3002a5264f22544b5ff394355b0605d5",
"assets/AssetManifest.json": "ec73f7af88b2c766f57febcef1707553",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/shaders/water_clouds.frag": "704f028da22dcab33db2ddda3180ca43",
"assets/NOTICES": "8a8dc93db08d77b4d77650540d2a61f3",
"main.dart.js_88.part.js": "390fcec336f5122eeb330fb7268168b7",
"main.dart.js_23.part.js": "760f8dc434ddeb76e37751f5cb59e29e",
"main.dart.js_67.part.js": "4af084aab241af56bba7f4a96f5132d7",
"main.dart.js_111.part.js": "6bc63800cce48c1c7a81141a4963460e",
"main.dart.js_114.part.js": "cee302a1fe01e2c8b6b4e889effafb89",
"main.dart.js_69.part.js": "7495a7ae03b06cfaed9c0366294514b8",
"main.dart.js_100.part.js": "9b3a987459f64fb4ce5e4ce4c701f158",
"manifest.json": "38212b39dd51df343b19bfa938e9ac4f",
"main.dart.js_78.part.js": "7d51ea2bb7bf2b6c6a8cf7ef1f33e953",
"main.dart.js_90.part.js": "e0190f1b24370b305c2fed1a9d3d6c56",
"main.dart.js_35.part.js": "5291970f45487590ebad0fbc76870f5e",
"main.dart.js_52.part.js": "6b50eb4307ded63d454df742589a8220",
"main.dart.js_95.part.js": "3314508998ec407cdacde7dc06d344bd",
"version.json": "6b8b9140b83c40f85633ddfcd9f81cd7",
"main.dart.js_109.part.js": "af81bc26752f4b2026c3c31876445078",
"main.dart.js_2.part.js": "871c2381d1cad7c7457f3963a6fb9f88",
"favicon.png": "306e7ba8f0872a8ae25be6aca7d80b7f",
"main.dart.js_45.part.js": "c262438b8ddb888137402f31578545f7",
"main.dart.js_56.part.js": "4ede3fb50779518395aca408ca1ea0da",
"main.dart.js_80.part.js": "01ff0e06aedc46ed8883cdcad9b3b884",
"main.dart.js_86.part.js": "ce92eacc98c9700458fa5d8c05112190",
"main.dart.js_12.part.js": "2ff89c6cd708b1ad999ab5589c0c6bc6"};
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
