'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"main.dart.js": "6b73789c6eab1792c8abe06a3ed8fd46",
"main.dart.js_98.part.js": "092c684fa869fd32abd2db4c66f02eb3",
"main.dart.js_66.part.js": "912eb4d697b9ed70b335d3f6ba21b5b2",
"main.dart.js_63.part.js": "458415493665fd7be594eef2c26bd54f",
"main.dart.js_32.part.js": "1d35a5049ca70411bb4fa32ca0710608",
"main.dart.js_75.part.js": "530b1faac1e40e0d7672ed3e66b5b068",
"main.dart.js_9.part.js": "ce2e04a0a0f2e4a4d4a66f892bd1088f",
"flutter_bootstrap.js": "e8caa3bd3112286bdb8fd479e964651a",
"main.dart.js_61.part.js": "185a08d1bef9dacc90499780b612f88b",
"main.dart.js_64.part.js": "3d22a9b833e0c0d77c5bf836c2ae3785",
"main.dart.js_60.part.js": "4ac6dd32dda79f3e40cd19e6354698e8",
"main.dart.js_102.part.js": "d3a8bd009302d397b59136c8ecd0657b",
"main.dart.js_76.part.js": "80b6e2c93d792105a08b2b901403fed0",
"main.dart.js_106.part.js": "d2a2ccdb1969e8cc206b057a417f7cce",
"main.dart.js_62.part.js": "c48aa026aa3c83e8b828db44e5e8b8b8",
"main.dart.js_68.part.js": "792eb35821979090ea31691cd74b1091",
"main.dart.js_83.part.js": "06dd0ba2278bee69d260ceed98eb56a3",
"canvaskit/canvaskit.js.symbols": "bdcd3835edf8586b6d6edfce8749fb77",
"canvaskit/canvaskit.wasm": "7a3f4ae7d65fc1de6a6e7ddd3224bc93",
"canvaskit/chromium/canvaskit.js.symbols": "b61b5f4673c9698029fa0a746a9ad581",
"canvaskit/chromium/canvaskit.wasm": "f504de372e31c8031018a9ec0a9ef5f0",
"canvaskit/chromium/canvaskit.js": "8191e843020c832c9cf8852a4b909d4c",
"canvaskit/skwasm.wasm": "39dd80367a4e71582d234948adc521c0",
"canvaskit/skwasm.js.symbols": "e72c79950c8a8483d826a7f0560573a1",
"canvaskit/canvaskit.js": "728b2d477d9b8c14593d4f9b82b484f3",
"canvaskit/skwasm.js": "ea559890a088fe28b4ddf70e17e60052",
"main.dart.js_79.part.js": "f39e75c05d880682504305482073be28",
"main.dart.js_71.part.js": "bec655a301efd1ea349e89016ad531d4",
"main.dart.js_41.part.js": "4a4d82c41c196b161297aba70d516d7d",
"main.dart.js_50.part.js": "17c177c448b874d5a539580fee66f78c",
"main.dart.js_40.part.js": "b342963e6cdc9b7bd150277d63d21912",
"main.dart.js_113.part.js": "5bf0940aacc2157208bf922998802b0c",
"main.dart.js_30.part.js": "2390ec4b857264fbe0669f0f275943b9",
"main.dart.js_51.part.js": "f6ec00700d898f8bbcbde9759b04fc07",
"main.dart.js_28.part.js": "c8992c4b220010363c34aa4727c8ae9b",
"main.dart.js_29.part.js": "a747b1d6f4e9db5ae5aa84e6821fda3f",
"main.dart.js_7.part.js": "fb88bd93a8a7dfb26e175bda9dce898d",
"main.dart.js_91.part.js": "7260712bfdf87ea44acc7828cfe53b57",
"main.dart.js_8.part.js": "c2bb87a19ca558e002740a16bb2e8a93",
"main.dart.js_25.part.js": "9acd2e9c896e8256d9fec4bffbae61c9",
"main.dart.js_103.part.js": "f1e9b20944cc890407ce7cce685cd2a1",
"main.dart.js_1.part.js": "e651a743e5dc73bdab97abc9490c57e5",
"main.dart.js_3.part.js": "746257f9cd51adf94321708aa8e79b5c",
"main.dart.js_34.part.js": "8416a46364e1b28bc298181144db2b8c",
"main.dart.js_22.part.js": "24df11f48b147198ced0611ea69b13a1",
"main.dart.js_14.part.js": "cb19d97263a682c43b2a5f7ba1935ebd",
"main.dart.js_49.part.js": "700acb6a1fbc9b4542074bbbc44a55fc",
"main.dart.js_20.part.js": "b483f8718eac31c0725dc2e1cb24503b",
"main.dart.js_105.part.js": "5f9b78a1b1bd5dae980eb3c830cf0a3d",
"main.dart.js_6.part.js": "cc8aa300d3133c2f7b0cd37cfa650a9a",
"main.dart.js_87.part.js": "1b17438412de64bfb62da8e3ebf5e4cd",
"main.dart.js_46.part.js": "57676f11b58befaa4845987e359c3466",
"main.dart.js_16.part.js": "0f97ba2802c35d52ee39fec330447743",
"main.dart.js_5.part.js": "5500ebf8300d1a14b5eb8a60f91f5f08",
"main.dart.js_57.part.js": "ddd83e93396af79627f8045dcb63e817",
"main.dart.js_82.part.js": "347e6dc5d8e9ece9f9649956a602f11a",
"main.dart.js_17.part.js": "a4c4b95463a7144e5bf6f96aa45d9f87",
"main.dart.js_36.part.js": "0ae383ca029afcdc0c2358cf56819367",
"main.dart.js_15.part.js": "d5dcbe26586257baf01a90ac159d6aac",
"main.dart.js_31.part.js": "b44ae2585fd198bbb04be5d92a8a0d98",
"main.dart.js_21.part.js": "42112bbbf05d4b826966a25c7cba5b6a",
"main.dart.js_10.part.js": "2e229aed299972f07713659a91a41263",
"main.dart.js_73.part.js": "764c6aa0f84215325a6d267ca3cfc5e4",
"main.dart.js_93.part.js": "db0c32621f238dc752fa32de018d7188",
"main.dart.js_115.part.js": "bd46d8f45cb6d958dfed7d1d32674633",
"main.dart.js_54.part.js": "391215ab73dd7e0f4aaeb8c60711bfef",
"main.dart.js_38.part.js": "bdf65853ad6c3a183458a3096a23cf6c",
"main.dart.js_116.part.js": "02cba299246c6fe15c683c52eae4253f",
"main.dart.js_74.part.js": "f2d359c5022124151a89f01624c72f6f",
"main.dart.js_53.part.js": "9ac75f30020c39635f0b2982e7712a3b",
"main.dart.js_96.part.js": "6ffe01c0000fc6b8c6565d3b05e50323",
"main.dart.js_81.part.js": "b4b1bf9067a3a9db929375dbbce1bff1",
"main.dart.js_19.part.js": "bfa839f13c4da10d88fd587f3426da04",
"main.dart.js_18.part.js": "e777ac2e351a0aa609b217c4488f25a9",
"main.dart.js_84.part.js": "d8fe4c63c77b77e4ab27354aa4abfdf2",
"main.dart.js_42.part.js": "a807d0a5da05db20c8b7f376102cf2fd",
"main.dart.js_55.part.js": "ebe081f16b79c0fd09b115b8d5fcb49a",
"main.dart.js_107.part.js": "71be0519ca19acab870a3c1228f99372",
"main.dart.js_44.part.js": "0cdf9018243bf8e2fcdb0aa2139bc839",
"main.dart.js_65.part.js": "1ef31f3c4f3fc9290a1d810cb14c5e79",
"main.dart.js_72.part.js": "bf8b4a9606436eb3080edd6489a1c02f",
"icons/Icon-maskable-512.png": "274a1e917760a1f046d666e6202d023a",
"icons/Icon-maskable-96.png": "91ebf99f57762a0a291d74ca8992d18c",
"icons/Icon-maskable-128.png": "246028210ed2ad790833d9bae1456df3",
"icons/Icon-192.png": "de2ec02df3a1869af4ad786b508d58d0",
"icons/Icon-maskable-192.png": "0bf4a53e4bdef76509c1639561988a14",
"icons/Icon-512.png": "80a96cdf564eb56bf72144a81d528408",
"main.dart.js_77.part.js": "b4cad97a9c2507dcb54f5d5170737ca2",
"main.dart.js_85.part.js": "cdc4bd70b79de55f8fdac4f37de792f1",
"main.dart.js_108.part.js": "9e97014a9296f044e89162e38ba7a9b1",
"main.dart.js_59.part.js": "c15630703c46fd0fc66d0a38d980f03a",
"main.dart.js_94.part.js": "fca8cefc5e92a7021da6b71799903ebc",
"main.dart.js_89.part.js": "faddeab35e9e5a2865116bcafa656ee9",
"main.dart.js_70.part.js": "8c833f0222970cc266574de84a97c11c",
"main.dart.js_33.part.js": "a5498bb5342fc354ab82868f78d5d503",
"flutter.js": "83d881c1dbb6d6bcd6b42e274605b69c",
"main.dart.js_58.part.js": "6cba334073c7ec8c407322115ae6f314",
"main.dart.js_24.part.js": "6decfd29ce9c3837adba71d3d111202b",
"main.dart.js_48.part.js": "2556b4811b7f7eef10ee648a97dffcf3",
"main.dart.js_92.part.js": "7604c7edc46a0388f6e294313b02a260",
"main.dart.js_110.part.js": "b9957b90ce71300d73957b05ab129907",
"main.dart.js_104.part.js": "373201dfd1d26f7b5fd894c3114158dc",
"main.dart.js_11.part.js": "9d81a4c4699045335a0b169fced1aa8c",
"index.html": "03563f3989cddd6c542d2256590bb1a8",
"/": "03563f3989cddd6c542d2256590bb1a8",
"main.dart.js_4.part.js": "3019db400f2ff53ed35a9a6b85be889a",
"main.dart.js_97.part.js": "8183019676ced6337f5f49caa14acb72",
"main.dart.js_26.part.js": "b6b5f5dfcd8bd76107a4286fe32b7293",
"main.dart.js_47.part.js": "7db4a5948d0cfbfad2ae40ad7ab4f22e",
"main.dart.js_37.part.js": "80e7d16bab2a4b11f23ae91eb87ea7a7",
"main.dart.js_27.part.js": "11f612d2cb0e6334050433901e5160fd",
"main.dart.js_99.part.js": "9f8024931fad5da7a312eacbc91c9b9e",
"main.dart.js_13.part.js": "b4d313b545c564f21a11531da3bcae17",
"main.dart.js_112.part.js": "c108338881f27fc9d87250bb5cc348d5",
"main.dart.js_43.part.js": "e888dac077b6123af95377ddc2ff5e94",
"main.dart.js_39.part.js": "c7a5670d68dbc2b8215776234fbacfbf",
"assets/AssetManifest.bin": "cd5d7abf98054bdf8a9d1c8eb941fcd0",
"assets/cargoship/iconttf/RpgAwesome.ttf": "3fb8d0aa42860e8db819f5d3c65834c5",
"assets/cargoship/builtin_fonts/Palatino_bold.ttf": "975972a205fd91a532d1b7433281af70",
"assets/cargoship/builtin_fonts/Palatino_italic.ttf": "be4590eba976dace111b6686f6dade52",
"assets/cargoship/builtin_fonts/Rubik-VariableFont_wght.ttf": "6d3102fa33194bef395536d580f91b56",
"assets/cargoship/builtin_fonts/Palatino_roman.ttf": "96261bb90c9babbf8042ce7f43200d65",
"assets/cargoship/builtin_fonts/Palatino_bolditalic.ttf": "beef66370e7124eb683514ad9ad07576",
"assets/AssetManifest.bin.json": "50204dc89005b799bf8b48ba16a1d3d7",
"assets/fonts/MaterialIcons-Regular.otf": "6d159077de259d94cfba0155cfb7505c",
"assets/FontManifest.json": "3002a5264f22544b5ff394355b0605d5",
"assets/AssetManifest.json": "845139c6a2d4e9245bbe46e978b2be42",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/NOTICES": "9c1692f49e2646eac51f22def6eece56",
"main.dart.js_88.part.js": "b8aabbb7d2191bc205ee67501d7b37dc",
"main.dart.js_23.part.js": "88e908211e036b8af516116a2b44e49c",
"main.dart.js_67.part.js": "d7fd12cc3bacb4f09c06c53da42fea2c",
"main.dart.js_111.part.js": "72d43f155577e1171f4c61ce729767a3",
"main.dart.js_114.part.js": "e4ebe44e14bb038f28eb8e08fea6c982",
"main.dart.js_69.part.js": "de59447c0c84853b255e90cf5988ca55",
"main.dart.js_100.part.js": "129b9600b80a1136d42a62394e10f2cb",
"manifest.json": "38212b39dd51df343b19bfa938e9ac4f",
"main.dart.js_78.part.js": "a94242884fecd3ac116dc418b8dc26bd",
"main.dart.js_90.part.js": "c90227e8a0adf7321d86363a06cd7210",
"main.dart.js_35.part.js": "eb92ae511998b96ae1416a8eed7c8660",
"main.dart.js_52.part.js": "1c57f7f758140e5edc1e5b5f20c66445",
"main.dart.js_95.part.js": "75e2ec51d109132968de8f90b128b008",
"version.json": "6b8b9140b83c40f85633ddfcd9f81cd7",
"main.dart.js_109.part.js": "2525151fa65f9b469de9c898e4d96d0a",
"main.dart.js_2.part.js": "be3439e908435b2a2c33f9d913210a11",
"favicon.png": "306e7ba8f0872a8ae25be6aca7d80b7f",
"main.dart.js_45.part.js": "18c8e17b5a12e520f2ef49bd952ec169",
"main.dart.js_56.part.js": "9c15f58c0a0fff4759fdbc6ccf990699",
"main.dart.js_80.part.js": "b551cd3159903bae0dfe6d106ea57e30",
"main.dart.js_86.part.js": "f1cacec7c16710b52502c9acfe4d1dd9",
"main.dart.js_12.part.js": "01e88e53798cda130edad74a3bdd905e"};
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
