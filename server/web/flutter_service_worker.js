'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"main.dart.js": "449822eea975c93c8fe2e6f0a5460eaf",
"main.dart.js_98.part.js": "296440812b551dc6f08eccc30c0cec13",
"main.dart.js_66.part.js": "cb66bc629d11ab42d625f5db5f1f4fe4",
"main.dart.js_63.part.js": "13fe7d15ccbc4babb92fb9b51b7ff94e",
"main.dart.js_32.part.js": "70a5a82bcf7c4ca3e806eb21cbd523fc",
"main.dart.js_75.part.js": "a401735057ad61442d1d3ac47780bafd",
"main.dart.js_9.part.js": "e5634663ef380dcb5e60897a305630f0",
"flutter_bootstrap.js": "6266a374f63fb92953b6a301d48915e7",
"main.dart.js_61.part.js": "cf11b80c98af8c6b91b42b7b2b4926f9",
"main.dart.js_64.part.js": "a9ca70c9b3b3c32899bf4fe44a05e1fd",
"main.dart.js_60.part.js": "4b2c41daa57678c9796a310c57fe72f8",
"main.dart.js_102.part.js": "59bde21416d478500e58ae517dd7d1ec",
"main.dart.js_76.part.js": "b13a3a68d0f63ae44ab279a86093c649",
"main.dart.js_106.part.js": "f3d088777ce94cf526919565f69446c2",
"main.dart.js_62.part.js": "c8f83dfd1fd74caf6fcb341ef72ebfde",
"main.dart.js_68.part.js": "454248c6bd91abe621930b3a838d3f8c",
"main.dart.js_83.part.js": "dab3932bc8c416d84cc04a74f3bad40c",
"canvaskit/canvaskit.js.symbols": "bdcd3835edf8586b6d6edfce8749fb77",
"canvaskit/canvaskit.wasm": "7a3f4ae7d65fc1de6a6e7ddd3224bc93",
"canvaskit/chromium/canvaskit.js.symbols": "b61b5f4673c9698029fa0a746a9ad581",
"canvaskit/chromium/canvaskit.wasm": "f504de372e31c8031018a9ec0a9ef5f0",
"canvaskit/chromium/canvaskit.js": "8191e843020c832c9cf8852a4b909d4c",
"canvaskit/skwasm.wasm": "39dd80367a4e71582d234948adc521c0",
"canvaskit/skwasm.js.symbols": "e72c79950c8a8483d826a7f0560573a1",
"canvaskit/canvaskit.js": "728b2d477d9b8c14593d4f9b82b484f3",
"canvaskit/skwasm.js": "ea559890a088fe28b4ddf70e17e60052",
"main.dart.js_79.part.js": "d547c99bf9cf784535e1abcbd0cebbd3",
"main.dart.js_71.part.js": "6be086a1a9edc147e7cba3c1054b663b",
"main.dart.js_41.part.js": "433756fef834591c12bd692c35106d03",
"main.dart.js_50.part.js": "fb6e962ef2f668e5069a8a2b4767e687",
"main.dart.js_40.part.js": "14511f4e977f34e3921f5325ce5a5b7b",
"main.dart.js_113.part.js": "56ffd7593580dc5dc6c97a24378fa04e",
"main.dart.js_101.part.js": "031e060a100897f21bd49e244cac068c",
"main.dart.js_30.part.js": "8da47c7802149d271b1f85a871b8713e",
"main.dart.js_51.part.js": "961fc86c55e18c73af4c5e59558a3afb",
"main.dart.js_28.part.js": "7c908c0e529c6fc3eeff58c3f003682a",
"main.dart.js_29.part.js": "7c023a47fa597de717b6def939f25d18",
"main.dart.js_7.part.js": "c34926cc382d4c7d37decdbdc2e0646c",
"main.dart.js_91.part.js": "cbeb45c8bb10e557d2eb9ff14ac2821b",
"main.dart.js_8.part.js": "501ffa678a07240640e7088f83797162",
"main.dart.js_25.part.js": "a63bad627074fab23a07c51ca8d0ccb9",
"main.dart.js_103.part.js": "69614ba8a4f28deb938537b00d3d49a9",
"main.dart.js_1.part.js": "a8e91a7f5f11b7d5d83b60c8bd0ed9ae",
"main.dart.js_3.part.js": "5687d078adc237ed449ddad7a3f2c1d8",
"main.dart.js_34.part.js": "1ccbf89580b80e9bad6f4a9447b2b111",
"main.dart.js_126.part.js": "4ce13bf3f498556db273ca5e5043d6b5",
"main.dart.js_22.part.js": "041bb8929a684b53446b1ca57d0a8207",
"main.dart.js_14.part.js": "95271acd5b69b91a04ab126d8a4c1321",
"main.dart.js_49.part.js": "4d67a71568e8555cd57dd813eb98add5",
"main.dart.js_20.part.js": "9cca7b4ed56a9156f9ede55fe6a8aacf",
"main.dart.js_118.part.js": "89601f6c355f289f45cec8700f5b7f48",
"main.dart.js_105.part.js": "90d714de4e2fb38df4aa692e5332dbdc",
"main.dart.js_6.part.js": "853d8eafb4030b45dd20a49947056cab",
"main.dart.js_87.part.js": "3cf5e0524e7c82cb02fb10d7c576f5f1",
"main.dart.js_46.part.js": "5d8e0809176bbc3d98b5243d52fed31f",
"main.dart.js_16.part.js": "4efe6f541dc1d66897262e25a8f47d20",
"main.dart.js_5.part.js": "a53daab9c06ff456b18ad156c57b7a3b",
"main.dart.js_57.part.js": "09ce1d12a78f3856cc391713324ee9c8",
"main.dart.js_82.part.js": "561574a1617ba02f6f3268b528cfdc94",
"main.dart.js_17.part.js": "a7aa05dfd9b53c37bb302f3cf1e34d36",
"main.dart.js_36.part.js": "b1ceb4dcf43639ac9dfe687e67e1c6c7",
"main.dart.js_15.part.js": "7ab9d0545d4246962a710a54333879ca",
"main.dart.js_31.part.js": "b8df70214dad5e4883be334fa1e9eb18",
"main.dart.js_21.part.js": "5958ccfea86eca6f62d47273f24af06b",
"main.dart.js_10.part.js": "9d4655203332026010ab1855a60d2a8b",
"main.dart.js_73.part.js": "30c74d24e3f3d0853ea83d4b9b3d1be5",
"main.dart.js_93.part.js": "2619a3210c537f5c63ee0897f49356fb",
"main.dart.js_115.part.js": "b5f60c931f0bdec32f403a38e7535244",
"main.dart.js_119.part.js": "cec264a08b845052a4db656ff6dffb22",
"main.dart.js_54.part.js": "7d79c421ed54bced7f7e7083f234572d",
"main.dart.js_123.part.js": "f652052c81a8ce26e9729c2926c8fdaf",
"main.dart.js_38.part.js": "fdc5de3ab24b2b7eb14323fe5bc9ed75",
"main.dart.js_117.part.js": "680e19f1d0a62444e06c7c5d859bb66a",
"main.dart.js_116.part.js": "cac70bcd6420e33859163f4d2aa5e054",
"main.dart.js_74.part.js": "f98013f22b150c406cd27689343b180c",
"main.dart.js_125.part.js": "c7739aa74c363d1b2749d4c241fb80d6",
"main.dart.js_53.part.js": "1d761011883524e30b0dae6f6118bd32",
"main.dart.js_96.part.js": "4fe0bb0296a05ab5ba4af89a9837b188",
"main.dart.js_81.part.js": "0853447aa346daafb6ed277ffada0926",
"main.dart.js_19.part.js": "0a046bd2113c763c5110b24da6fcae5a",
"main.dart.js_18.part.js": "aa9b10ae9f7dd6ac6bf90e7fea191284",
"main.dart.js_84.part.js": "c786c69b1cd13b790f5e5a131721e5e7",
"main.dart.js_42.part.js": "d6681032f5859e00fd5d533a1708ae8d",
"main.dart.js_55.part.js": "c7c1c678e6f9fd80766aed45218f35f7",
"main.dart.js_107.part.js": "9e8f2f86e3910926f221d8f19b098ef1",
"main.dart.js_44.part.js": "21c0139be7a7ae38ca6ec759aa9bf3d8",
"main.dart.js_65.part.js": "d7df3761be2ff79fa5e7cb2498aeb60d",
"main.dart.js_72.part.js": "b0ea9af028d1ca5e810e874c4915980d",
"icons/Icon-maskable-512.png": "274a1e917760a1f046d666e6202d023a",
"icons/Icon-maskable-96.png": "91ebf99f57762a0a291d74ca8992d18c",
"icons/Icon-maskable-128.png": "246028210ed2ad790833d9bae1456df3",
"icons/Icon-192.png": "de2ec02df3a1869af4ad786b508d58d0",
"icons/Icon-maskable-192.png": "0bf4a53e4bdef76509c1639561988a14",
"icons/Icon-512.png": "80a96cdf564eb56bf72144a81d528408",
"main.dart.js_77.part.js": "7fb541881587e2bb335f69b78410b767",
"main.dart.js_85.part.js": "604c0db8c148c56c749df99d792e9cc4",
"main.dart.js_108.part.js": "3b7006a5685b2219154b841f9fbb5b87",
"main.dart.js_59.part.js": "b23ed4e41ffa6afcb45d0f408d74911b",
"main.dart.js_94.part.js": "09a26c5f2c07a1d968ed5403ba713cbb",
"main.dart.js_89.part.js": "70e365f0fbe7caddcf02bf7664941813",
"main.dart.js_70.part.js": "5e55bb498032209a7fe11118e58f4274",
"main.dart.js_33.part.js": "d2f41acc25a465ddc679d83080f88c66",
"flutter.js": "83d881c1dbb6d6bcd6b42e274605b69c",
"main.dart.js_58.part.js": "523ccb478e42464922a5513815936a13",
"main.dart.js_24.part.js": "ca2f52f9e6aa8599bd177f2de4a393ed",
"main.dart.js_48.part.js": "38e3e2f67d1635f5046dd342b435c2e3",
"main.dart.js_92.part.js": "2d8895be1a2092f39c586a5522c4fc4a",
"main.dart.js_110.part.js": "09b4e13514e2ad15e4c17ddba509b9f5",
"main.dart.js_104.part.js": "e3735eac96666c8460dbd66dedbcc9a0",
"main.dart.js_11.part.js": "43f4c09918d65a73449b00b8465371fc",
"main.dart.js_124.part.js": "b8689ee0ceddaa9ab87dff29c5e625ca",
"index.html": "183c04a1a369f5a77c1b22c907fc91e7",
"/": "183c04a1a369f5a77c1b22c907fc91e7",
"main.dart.js_4.part.js": "bb88ac7fa9949a47f0f74297984e54f5",
"main.dart.js_97.part.js": "09aea3da67a8455a5123e4337c9bf03e",
"main.dart.js_26.part.js": "97b67672c53b148dff6c0ee545e513f8",
"main.dart.js_47.part.js": "604d1966f7550a089853ed99b5856a71",
"main.dart.js_127.part.js": "e6d1fab7a4a4458e2587da11db897388",
"main.dart.js_37.part.js": "dba74bf75c114e4d3ef7413c1f0aa8d6",
"main.dart.js_27.part.js": "83eaabafb619f3dfe95866fd36b260d7",
"main.dart.js_99.part.js": "067a90fa0a80b8c5e2423693029acbbc",
"main.dart.js_13.part.js": "ea392740d1b75968dff7d991987eb39a",
"main.dart.js_112.part.js": "562556daa15114927071d8b3cef45080",
"main.dart.js_43.part.js": "8570e296f375fa02cdbb285136038e64",
"main.dart.js_39.part.js": "0742884bf129b6d99622e4e6bb4d9f73",
"assets/AssetManifest.bin": "eb9126b4e5ae49971137bb64d6cff5f3",
"assets/cargoship/iconttf/RpgAwesome.ttf": "3fb8d0aa42860e8db819f5d3c65834c5",
"assets/cargoship/builtin_fonts/Palatino_bold.ttf": "975972a205fd91a532d1b7433281af70",
"assets/cargoship/builtin_fonts/Palatino_italic.ttf": "be4590eba976dace111b6686f6dade52",
"assets/cargoship/builtin_fonts/Rubik-VariableFont_wght.ttf": "6d3102fa33194bef395536d580f91b56",
"assets/cargoship/builtin_fonts/Palatino_roman.ttf": "96261bb90c9babbf8042ce7f43200d65",
"assets/cargoship/builtin_fonts/Palatino_bolditalic.ttf": "beef66370e7124eb683514ad9ad07576",
"assets/AssetManifest.bin.json": "3ef8031b6c1baa93e3f709a6f2cdfdad",
"assets/fonts/MaterialIcons-Regular.otf": "f82a20c165f80685cf3400f52fc529f7",
"assets/FontManifest.json": "5bf5570bf3efc7b2862937a369b1b0df",
"assets/AssetManifest.json": "e4dae148b301d722c5fc55a227712fab",
"assets/packages/material_symbols_icons/lib/fonts/MaterialSymbolsSharp.ttf": "e949713f8bb3a755d44ac95a5a424214",
"assets/packages/material_symbols_icons/lib/fonts/MaterialSymbolsOutlined.ttf": "0b278141b31b5af0539217a067b5469c",
"assets/packages/material_symbols_icons/lib/fonts/MaterialSymbolsRounded.ttf": "871547b681b7ee47ebad5dcd3b316573",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/shaders/water_clouds.frag": "704f028da22dcab33db2ddda3180ca43",
"assets/NOTICES": "4285cfd938c0dbf845be004aa6c43218",
"main.dart.js_88.part.js": "390fcec336f5122eeb330fb7268168b7",
"main.dart.js_23.part.js": "760f8dc434ddeb76e37751f5cb59e29e",
"main.dart.js_121.part.js": "d0252cd99c7c902223973c4a3befbeea",
"main.dart.js_67.part.js": "4af084aab241af56bba7f4a96f5132d7",
"main.dart.js_111.part.js": "6bc63800cce48c1c7a81141a4963460e",
"main.dart.js_114.part.js": "42627b13d358791673d23bb7eaa5a08a",
"main.dart.js_122.part.js": "88a6e5b4d8d1c07efb23e63bb2e2f6d5",
"main.dart.js_69.part.js": "f37d940402104a3f8c7f292206edcd7b",
"main.dart.js_100.part.js": "9d58888384baf940ebfca66a0df043bd",
"manifest.json": "38212b39dd51df343b19bfa938e9ac4f",
"main.dart.js_78.part.js": "aa349332496d7fbd9c581f4fcc9ebd18",
"main.dart.js_90.part.js": "5299cebd5a57ee0168c3e0681ab1bbfc",
"main.dart.js_35.part.js": "34f1a2f138d6f7e79de49fb3c7f9b739",
"main.dart.js_52.part.js": "e89eb0ca87a1b616a60206438c573d59",
"main.dart.js_95.part.js": "3314508998ec407cdacde7dc06d344bd",
"version.json": "6b8b9140b83c40f85633ddfcd9f81cd7",
"main.dart.js_109.part.js": "c435213eee15223d961e98647e36337c",
"main.dart.js_2.part.js": "5334fb908f5cb79e7f761ceacfbe962e",
"favicon.png": "306e7ba8f0872a8ae25be6aca7d80b7f",
"main.dart.js_45.part.js": "c262438b8ddb888137402f31578545f7",
"main.dart.js_56.part.js": "4ede3fb50779518395aca408ca1ea0da",
"main.dart.js_80.part.js": "01ff0e06aedc46ed8883cdcad9b3b884",
"main.dart.js_86.part.js": "85df107488b31a8b9ea5f9528f92b3ab",
"main.dart.js_12.part.js": "7b78a6d33dbd25f6b3556039b31df65f"};
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
