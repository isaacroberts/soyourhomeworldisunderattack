'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"main.dart.js": "7f0a81c56568d6ed5760b61b86f67281",
"main.dart.js_66.part.js": "8b2a6bdb757857b1b258bb0c96b61ef7",
"main.dart.js_63.part.js": "c6e83556ac0d53b5d98a183e45fdf88b",
"main.dart.js_32.part.js": "41aa91c0c11d25d6a048dcbb4e7e4333",
"main.dart.js_75.part.js": "e4f680413999c3efed78ca491575f9d1",
"main.dart.js_9.part.js": "d48f6fafa700ee6845826fb7d0bf5e86",
"flutter_bootstrap.js": "71d4063938cb53c0debfabc8a39f35e6",
"main.dart.js_61.part.js": "1ef8b19d3c7ae81fb2cf2796623e0410",
"main.dart.js_64.part.js": "ff847558d1c184c866dbe66dbe3a9231",
"main.dart.js_76.part.js": "cbab615e1f63df3de568a34a608e4574",
"main.dart.js_62.part.js": "273bfed7617a9b1de1d91e8d8d762cc9",
"main.dart.js_68.part.js": "b4ef45a91ab4a7db2320339dd2fc9659",
"main.dart.js_83.part.js": "10d86e3c7753d0061c0ba3891f58312c",
"canvaskit/canvaskit.js.symbols": "27361387bc24144b46a745f1afe92b50",
"canvaskit/canvaskit.wasm": "a37f2b0af4995714de856e21e882325c",
"canvaskit/chromium/canvaskit.js.symbols": "f7c5e5502d577306fb6d530b1864ff86",
"canvaskit/chromium/canvaskit.wasm": "c054c2c892172308ca5a0bd1d7a7754b",
"canvaskit/chromium/canvaskit.js": "8191e843020c832c9cf8852a4b909d4c",
"canvaskit/skwasm.wasm": "1c93738510f202d9ff44d36a4760126b",
"canvaskit/skwasm.js.symbols": "9fe690d47b904d72c7d020bd303adf16",
"canvaskit/canvaskit.js": "728b2d477d9b8c14593d4f9b82b484f3",
"canvaskit/skwasm.js": "ea559890a088fe28b4ddf70e17e60052",
"main.dart.js_79.part.js": "bfbdc7e0e4e27333768b85bad9b40e72",
"main.dart.js_71.part.js": "ab1989d8507277117da4c731d3dba6d6",
"main.dart.js_41.part.js": "1416935ef0bae50b8c1bf0af13977dce",
"main.dart.js_50.part.js": "423d11bc2f26c33984f2da453757cddb",
"main.dart.js_40.part.js": "c2decea65fa9af3b6281ab37bea5084a",
"main.dart.js_30.part.js": "f0526b443e83b63d1015c8aba69a647a",
"main.dart.js_51.part.js": "f61d000592478c8e370ed85dc0aece28",
"main.dart.js_28.part.js": "b56a9478d53cf42924d72fcba5b39b14",
"main.dart.js_29.part.js": "b8fee6f307ee7f3c6e6659ae9051247c",
"main.dart.js_7.part.js": "dad62559c1270e9751d3e7c96c832f6b",
"main.dart.js_91.part.js": "72e99f3ab3b2ed81984ab54172e124be",
"main.dart.js_8.part.js": "354c670d3abb7fb04a4798edb980364b",
"main.dart.js_25.part.js": "d3dff7354895b67bd540e1b2998d7880",
"main.dart.js_1.part.js": "b5c9b1babc45ac91612eee836974cd55",
"main.dart.js_3.part.js": "30397a25ed4d13a3550a207f5fb73819",
"main.dart.js_34.part.js": "65190fbc7c9a9c195e3735aa012fe850",
"main.dart.js_49.part.js": "26cd66f9ec101a91fe1ccebe2542c68f",
"main.dart.js_20.part.js": "bb6bdfb3d4ad6c75a36405045f41b808",
"main.dart.js_6.part.js": "7ef2607383f8fdf1034b84ecf3106ace",
"main.dart.js_87.part.js": "072db32f6470b72b79064118d2a5e4f5",
"main.dart.js_46.part.js": "55cfc7033b9122e224d039fc637528ad",
"main.dart.js_16.part.js": "902f037de1afdd6e5a1a55ee5894c583",
"main.dart.js_5.part.js": "cdd76c1b891112b15f0305088b1e421e",
"main.dart.js_57.part.js": "6865908afb9c85a409f5a699efbe9894",
"main.dart.js_17.part.js": "66b8ff6fe1201a166469722b049533f3",
"main.dart.js_31.part.js": "a10ede371e97822ce5fb44e0b1e865d0",
"main.dart.js_21.part.js": "32a3a7187c0e59a1cf4654169ee63239",
"main.dart.js_10.part.js": "2a9ceb62bb63a6a5a0d541bb420cb34e",
"main.dart.js_73.part.js": "4e52f8b203aedd563ad4266538719aae",
"main.dart.js_93.part.js": "f3bb5adb3099186f8d2fbcaa09e0c045",
"main.dart.js_74.part.js": "54ec67f1af1c935f48148d951131230b",
"main.dart.js_53.part.js": "108104421fcfaffe49b9efd7e50f9119",
"main.dart.js_96.part.js": "d1124c108f455375431ac09794cae126",
"main.dart.js_81.part.js": "5fc201cf6a908ff9df9ffdf13b170b6f",
"main.dart.js_19.part.js": "77f9eba72801f277c71daf312dd23131",
"main.dart.js_84.part.js": "64c27560dbdfc2c114ebdf49b5044e3a",
"main.dart.js_55.part.js": "2ae1d824b97152221e3b446c7e22a341",
"main.dart.js_44.part.js": "5b0a9e61627f65323f5941e401671471",
"main.dart.js_65.part.js": "92b07fa79f5091503af26a54d3e233ef",
"main.dart.js_72.part.js": "2e66da9147e8fc7808f2e24457cc912b",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"main.dart.js_77.part.js": "bc2485221aad8d441109d8a902362150",
"main.dart.js_85.part.js": "5001479dbe41bcda424081531278da87",
"main.dart.js_59.part.js": "588a4efb709174a6ef6e137cc9a616ed",
"main.dart.js_94.part.js": "b56db9f1b05c0a26d21456566ce283cd",
"main.dart.js_89.part.js": "5a859d247d336437528bc9699ef38cd3",
"main.dart.js_33.part.js": "ad8651d0bd1860dbaa4b7a86dd2173e5",
"flutter.js": "83d881c1dbb6d6bcd6b42e274605b69c",
"main.dart.js_58.part.js": "5193996b7cc4eb9dd2858c7fae374c52",
"main.dart.js_24.part.js": "83b019487268920469a0d10d42755b94",
"main.dart.js_48.part.js": "9a9d28ea806523534667e64e72a657b9",
"main.dart.js_92.part.js": "855a0ce94c1d7a8116b02c266b066531",
"main.dart.js_11.part.js": "a8cb901334970e95e05621252a4e2aed",
"index.html": "2c5bb45b65a51a887d2f33b17bbfac0a",
"/": "2c5bb45b65a51a887d2f33b17bbfac0a",
"main.dart.js_4.part.js": "afaad2a4b2f9ab63816054c23ca3cf91",
"main.dart.js_47.part.js": "a0df95683c91a4a92faf4231bdc5c4ee",
"main.dart.js_13.part.js": "407d890d4a91593140eec1b663e74be6",
"main.dart.js_43.part.js": "c9cedcd93da69b779d39c3420026bcb0",
"assets/AssetManifest.bin": "cd5d7abf98054bdf8a9d1c8eb941fcd0",
"assets/cargoship/iconttf/RpgAwesome.ttf": "3fb8d0aa42860e8db819f5d3c65834c5",
"assets/cargoship/builtin_fonts/Palatino_bold.ttf": "975972a205fd91a532d1b7433281af70",
"assets/cargoship/builtin_fonts/Palatino_italic.ttf": "be4590eba976dace111b6686f6dade52",
"assets/cargoship/builtin_fonts/Rubik-VariableFont_wght.ttf": "6d3102fa33194bef395536d580f91b56",
"assets/cargoship/builtin_fonts/Palatino_roman.ttf": "96261bb90c9babbf8042ce7f43200d65",
"assets/cargoship/builtin_fonts/Palatino_bolditalic.ttf": "beef66370e7124eb683514ad9ad07576",
"assets/AssetManifest.bin.json": "50204dc89005b799bf8b48ba16a1d3d7",
"assets/fonts/MaterialIcons-Regular.otf": "b49440dcdc3e3ea44fc929f920a9b300",
"assets/FontManifest.json": "783c3230dfdaf0638aa3ae02601bc419",
"assets/AssetManifest.json": "845139c6a2d4e9245bbe46e978b2be42",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/NOTICES": "9c1692f49e2646eac51f22def6eece56",
"main.dart.js_88.part.js": "ef23b446c148f139b69186e2d22ea058",
"main.dart.js_23.part.js": "331e2e73067a2053e740a04fb20f0642",
"main.dart.js_67.part.js": "74529d4486a1ab3ff9119d866bebd4ae",
"manifest.json": "f41a1bcf7dd669f69c5758ad491dac0c",
"main.dart.js_90.part.js": "1fe9b9c03dbb5bc25c918c3f6de3590a",
"main.dart.js_35.part.js": "ad5fdc74778830f17372ae8da37dba9a",
"main.dart.js_52.part.js": "c7da2f1a5904d97e7def9492e4abfc39",
"main.dart.js_95.part.js": "9eed5469558921d8423be75ae9603a73",
"version.json": "6b8b9140b83c40f85633ddfcd9f81cd7",
"main.dart.js_2.part.js": "4019c7ff129e42570e279558318f6cff",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"main.dart.js_45.part.js": "34fb0e1d52b6e98e334f710904369d5d",
"main.dart.js_80.part.js": "c466e17ecd7503a1d2b84f69243d9668",
"main.dart.js_86.part.js": "ac4dca9f2963fe986bf36b358ad279ae"};
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
