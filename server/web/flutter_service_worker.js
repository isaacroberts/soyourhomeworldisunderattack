'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"main.dart.js": "d544a062f19e5e4bda17cc7a1a8aae96",
"main.dart.js_98.part.js": "78cb22ab625aa6f40b015637584ab067",
"main.dart.js_66.part.js": "e3d4372a32de98156e36f15128cd706b",
"main.dart.js_75.part.js": "3ce3d1fe0c8da926da372b974507147e",
"main.dart.js_9.part.js": "726c0e1250a6703f8e275bc375a3f296",
"flutter_bootstrap.js": "8a4e59e7257a04c1afe569df1bae61a6",
"main.dart.js_64.part.js": "5295c6ecc516f84ea254b84b95bf2dfd",
"main.dart.js_60.part.js": "e4fe08e1fbf4a3fe01156ba348d0c8bd",
"main.dart.js_102.part.js": "03ac49ec02c11963a254de64251b9207",
"main.dart.js_76.part.js": "047cbb0bf8938069bd294d4b894db587",
"main.dart.js_62.part.js": "7d1fce3f9fd0980717b277934b23ae2c",
"main.dart.js_68.part.js": "b0c873c4685389e86879a268e95ad645",
"main.dart.js_83.part.js": "af656ee7bf649da17bd5f1cac67bf4fc",
"canvaskit/canvaskit.js.symbols": "27361387bc24144b46a745f1afe92b50",
"canvaskit/canvaskit.wasm": "a37f2b0af4995714de856e21e882325c",
"canvaskit/chromium/canvaskit.js.symbols": "f7c5e5502d577306fb6d530b1864ff86",
"canvaskit/chromium/canvaskit.wasm": "c054c2c892172308ca5a0bd1d7a7754b",
"canvaskit/chromium/canvaskit.js": "8191e843020c832c9cf8852a4b909d4c",
"canvaskit/skwasm.wasm": "1c93738510f202d9ff44d36a4760126b",
"canvaskit/skwasm.js.symbols": "9fe690d47b904d72c7d020bd303adf16",
"canvaskit/canvaskit.js": "728b2d477d9b8c14593d4f9b82b484f3",
"canvaskit/skwasm.js": "ea559890a088fe28b4ddf70e17e60052",
"main.dart.js_71.part.js": "407686dd980b079d0639083189b9a77c",
"main.dart.js_41.part.js": "603ca62b4ec96d37dad2bcc35fc6280c",
"main.dart.js_50.part.js": "d7cb0739126f6fa4eb3ab38543bea13e",
"main.dart.js_101.part.js": "2e80514474cf8a05d443f2f26d960858",
"main.dart.js_30.part.js": "ade1b9d9311e44db95e953bc09b6cc52",
"main.dart.js_51.part.js": "a2c0d821966c6d0cb8569c0d854e5700",
"main.dart.js_29.part.js": "28afaefb77ec8154db2bdc2719ef4dfa",
"main.dart.js_8.part.js": "83b6bb23717db8f3c68d4b393baa4ded",
"main.dart.js_103.part.js": "9003a459fb20ed6abd697f5c4e449c4a",
"main.dart.js_1.part.js": "3afee3909c260a8748fa933dd8303c1e",
"main.dart.js_3.part.js": "e49e8aebde4252fec7a967b730e08eb8",
"main.dart.js_34.part.js": "1bdb0dc28d64fd762592d4982df695cb",
"main.dart.js_22.part.js": "2f5fe72376f3c33f1a840cd972b01ad2",
"main.dart.js_14.part.js": "6dbf7323662ae2a5f81cc53772504351",
"main.dart.js_20.part.js": "4ede1e39ad87354a15035de6c77a6efb",
"main.dart.js_105.part.js": "f2a29dba262f1c7018d1f06d4268886c",
"main.dart.js_6.part.js": "0e91b1c4313e9e2ffed156b5d364d7fb",
"main.dart.js_87.part.js": "65a8395661f9083c1d10a0d39205ab45",
"main.dart.js_46.part.js": "bd621b1e2fc769d5d985caf9a5e5e327",
"main.dart.js_16.part.js": "6c34bd4e307ace94328c9fe5cc7020cb",
"main.dart.js_5.part.js": "9b31e188629c92db34a306cb9f202367",
"main.dart.js_57.part.js": "8509d6885efe28008f6479962ab485d4",
"main.dart.js_82.part.js": "4e4078a30649d0eb272d20ac4713d8ae",
"main.dart.js_17.part.js": "3cfba4173abab4d7cc7a627c0b128190",
"main.dart.js_36.part.js": "6605e5cb97b1340167b8038f397986e2",
"main.dart.js_15.part.js": "576863e01301e2d275a5da7129658889",
"main.dart.js_31.part.js": "75d86f6b9a11a72c5ce85bda11b6828c",
"main.dart.js_21.part.js": "0906de80e3dc3ddab36d2d6975fb6481",
"main.dart.js_73.part.js": "0716bc6062d53ed0c9aec40815d4668f",
"main.dart.js_93.part.js": "84b021fe48c72e458de92afaf47d426e",
"main.dart.js_54.part.js": "ec7b85a2b9a7f0281a27bf03d73106b9",
"main.dart.js_38.part.js": "2d7251067b662a8865e2d6f3ee1a8890",
"main.dart.js_74.part.js": "029bcd2077d28fd031f22e0e56254060",
"main.dart.js_96.part.js": "1d60dd543e1559b2e140ce95ae8aae4c",
"main.dart.js_81.part.js": "21530b3bfa2562b3409414bb479e0327",
"main.dart.js_19.part.js": "4d5d9438aa76e54feabfbedd91e91ee5",
"main.dart.js_18.part.js": "aeae871ffef30651a1f991cc2570a8d9",
"main.dart.js_84.part.js": "7b961360795090fe4a6e97509bcfae48",
"main.dart.js_42.part.js": "338797f2069fd1d0fae273582590db37",
"main.dart.js_55.part.js": "fdf7b7cfcd0a0e4f4c3ef7c6f224b7da",
"main.dart.js_44.part.js": "b6a4091311ca4e73a7fcb5e079fe0669",
"main.dart.js_65.part.js": "7161e5e6ab84d3d8070186d6f7513f9a",
"main.dart.js_72.part.js": "7594b6c81a870e0724ce5d1b15af358f",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"main.dart.js_77.part.js": "62a81298ab77c7f657a01cde4b981cfd",
"main.dart.js_85.part.js": "5212274705e3205250e6b7ce2dc83cb8",
"main.dart.js_59.part.js": "79d97219d40896ef3ac5d9f70991f8a1",
"main.dart.js_94.part.js": "8ad14641c755f9569685ec419fbd8810",
"main.dart.js_89.part.js": "351a5293e5c84d4d658804a714686ea1",
"main.dart.js_70.part.js": "d4d691a8c3f4602c220b9cb48770d675",
"main.dart.js_33.part.js": "6407833a0b73ccd14b67b4f139cf69c1",
"flutter.js": "83d881c1dbb6d6bcd6b42e274605b69c",
"main.dart.js_58.part.js": "f6ed718074b9dacddb785cfa3ed0f51e",
"main.dart.js_48.part.js": "f85618236cb5fed1fc496246b7b1a267",
"main.dart.js_92.part.js": "f3b1546c9fe7e7f1283c85cbaedc4541",
"main.dart.js_104.part.js": "f107410ab25cec7c7ab69058184ba44c",
"main.dart.js_11.part.js": "3301baa63e3282d30bce2d6b3b5959b6",
"index.html": "2c5bb45b65a51a887d2f33b17bbfac0a",
"/": "2c5bb45b65a51a887d2f33b17bbfac0a",
"main.dart.js_4.part.js": "3a25b70e83fa0622db6b80323675539c",
"main.dart.js_97.part.js": "c8cee04e6fee8f6e6fc436fa5adebe62",
"main.dart.js_26.part.js": "21e867a789cf390d3b31e98490de4c87",
"main.dart.js_47.part.js": "f60f9ba04bc37dffab4fb28e0f069b67",
"main.dart.js_37.part.js": "24ee10b149e34fc1beff4b9835e32854",
"main.dart.js_27.part.js": "b889848802f702e5a967d497d301cb61",
"main.dart.js_99.part.js": "0162cfa441f70dee4f48ad2734a1a054",
"main.dart.js_13.part.js": "8a03ad188453282b018e3cd7f1096348",
"main.dart.js_43.part.js": "4e180a1aabe79b88efa29df3f80243f7",
"assets/AssetManifest.bin": "cd5d7abf98054bdf8a9d1c8eb941fcd0",
"assets/cargoship/iconttf/RpgAwesome.ttf": "3fb8d0aa42860e8db819f5d3c65834c5",
"assets/cargoship/builtin_fonts/Palatino_bold.ttf": "975972a205fd91a532d1b7433281af70",
"assets/cargoship/builtin_fonts/Palatino_italic.ttf": "be4590eba976dace111b6686f6dade52",
"assets/cargoship/builtin_fonts/Rubik-VariableFont_wght.ttf": "6d3102fa33194bef395536d580f91b56",
"assets/cargoship/builtin_fonts/Palatino_roman.ttf": "96261bb90c9babbf8042ce7f43200d65",
"assets/cargoship/builtin_fonts/Palatino_bolditalic.ttf": "beef66370e7124eb683514ad9ad07576",
"assets/AssetManifest.bin.json": "50204dc89005b799bf8b48ba16a1d3d7",
"assets/fonts/MaterialIcons-Regular.otf": "cd3f2c6f28d35ed7ff7b76e805582b0e",
"assets/FontManifest.json": "3002a5264f22544b5ff394355b0605d5",
"assets/AssetManifest.json": "845139c6a2d4e9245bbe46e978b2be42",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/NOTICES": "9c1692f49e2646eac51f22def6eece56",
"main.dart.js_23.part.js": "1d6e58ae1bdd38e98588bcb13dd30b80",
"main.dart.js_67.part.js": "b52da359385bfc6fa05392a32d16b12a",
"main.dart.js_69.part.js": "6b4557cf00895c01e8c9aaed58763672",
"main.dart.js_100.part.js": "3a324834ce42ed6b28f219c16c488101",
"manifest.json": "f41a1bcf7dd669f69c5758ad491dac0c",
"main.dart.js_90.part.js": "47530998981df184b76cd2d459ffac82",
"main.dart.js_52.part.js": "9ce0bead0ddd00c628ae0c4a78f7346f",
"main.dart.js_95.part.js": "51bc183a50f024b30118b20b194a697d",
"version.json": "6b8b9140b83c40f85633ddfcd9f81cd7",
"main.dart.js_2.part.js": "bc354347556539d039640e40972f88c9",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"main.dart.js_56.part.js": "ecba4215c0a33c770d84ccae4fef42cc",
"main.dart.js_80.part.js": "e19a5a38d7e11d73cb6e2f672ab4ab4d",
"main.dart.js_12.part.js": "3946186171e8002d8b47b343ce06841f"};
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
