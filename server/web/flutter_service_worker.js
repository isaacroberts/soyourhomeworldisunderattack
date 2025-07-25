'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"main.dart.js": "53746fd197c375ba21716d93c7f83253",
"main.dart.js_98.part.js": "580f68c9f149c9cb396cdf6d577104e5",
"main.dart.js_66.part.js": "362b95e81f881bb7522f37a620950766",
"main.dart.js_75.part.js": "215b6067d02bc19f73225ade5a7bc9d9",
"main.dart.js_9.part.js": "726c0e1250a6703f8e275bc375a3f296",
"flutter_bootstrap.js": "eeb42535093a46e852ffefc8395d0d96",
"main.dart.js_64.part.js": "cac1ec48b484c42894fd927d011bcad0",
"main.dart.js_60.part.js": "1bc2b9729edf3488f90a5a05d9dc3de4",
"main.dart.js_102.part.js": "572aac04de48ab9db64a5798e35a4feb",
"main.dart.js_76.part.js": "bb5141327166923b8d21acac4d7b9cd9",
"main.dart.js_62.part.js": "66a188f31b14d256fe53c3d79f718f39",
"main.dart.js_68.part.js": "b0c873c4685389e86879a268e95ad645",
"main.dart.js_83.part.js": "da9f4226031ee9ed62eb62907e051ba7",
"canvaskit/canvaskit.js.symbols": "27361387bc24144b46a745f1afe92b50",
"canvaskit/canvaskit.wasm": "a37f2b0af4995714de856e21e882325c",
"canvaskit/chromium/canvaskit.js.symbols": "f7c5e5502d577306fb6d530b1864ff86",
"canvaskit/chromium/canvaskit.wasm": "c054c2c892172308ca5a0bd1d7a7754b",
"canvaskit/chromium/canvaskit.js": "8191e843020c832c9cf8852a4b909d4c",
"canvaskit/skwasm.wasm": "1c93738510f202d9ff44d36a4760126b",
"canvaskit/skwasm.js.symbols": "9fe690d47b904d72c7d020bd303adf16",
"canvaskit/canvaskit.js": "728b2d477d9b8c14593d4f9b82b484f3",
"canvaskit/skwasm.js": "ea559890a088fe28b4ddf70e17e60052",
"main.dart.js_71.part.js": "aea071deb6da91bf67569312cd41ed24",
"main.dart.js_41.part.js": "603ca62b4ec96d37dad2bcc35fc6280c",
"main.dart.js_50.part.js": "d7cb0739126f6fa4eb3ab38543bea13e",
"main.dart.js_101.part.js": "ee689a443e12b3679cff414ed10bbfe0",
"main.dart.js_30.part.js": "9cf6065cda7858b9625b2da32113fbcd",
"main.dart.js_51.part.js": "00c5dd68a3c89306742784ba755e8094",
"main.dart.js_29.part.js": "297d5c246d775432fe201c79f5eb6a27",
"main.dart.js_8.part.js": "83b6bb23717db8f3c68d4b393baa4ded",
"main.dart.js_103.part.js": "0a8ff3b14d4d7ba3b6f18aa922bd92ce",
"main.dart.js_1.part.js": "c29567a200a1b1da7a88878cadfc0fd5",
"main.dart.js_3.part.js": "9c39f4ae506038b900a42a12a4fa4405",
"main.dart.js_34.part.js": "36d21e21d3b840bb8a3dfac878b729bb",
"main.dart.js_22.part.js": "2f5fe72376f3c33f1a840cd972b01ad2",
"main.dart.js_14.part.js": "0d84c138089a93dadf00fe333e8650cd",
"main.dart.js_20.part.js": "4ede1e39ad87354a15035de6c77a6efb",
"main.dart.js_105.part.js": "fafbeb7f38f85cdc06ea3000c82f58c2",
"main.dart.js_6.part.js": "0e91b1c4313e9e2ffed156b5d364d7fb",
"main.dart.js_87.part.js": "befb7a443f6fd141dff4d11a3b7ae272",
"main.dart.js_46.part.js": "5ace04cac12cf118df1ef29cec81d858",
"main.dart.js_16.part.js": "6c34bd4e307ace94328c9fe5cc7020cb",
"main.dart.js_5.part.js": "5b5f5f63206c3dd15a887e27f6de581f",
"main.dart.js_57.part.js": "19fd034aa23c93525c6f5ec514136552",
"main.dart.js_82.part.js": "d6f340535b54a8da3d1e3163fed33aed",
"main.dart.js_17.part.js": "3cfba4173abab4d7cc7a627c0b128190",
"main.dart.js_36.part.js": "657b9c4b57713b72c5d0b7a9f7a187d5",
"main.dart.js_15.part.js": "576863e01301e2d275a5da7129658889",
"main.dart.js_31.part.js": "d0ceb1b12d05ee258305e38f2450c976",
"main.dart.js_21.part.js": "0906de80e3dc3ddab36d2d6975fb6481",
"main.dart.js_73.part.js": "0716bc6062d53ed0c9aec40815d4668f",
"main.dart.js_93.part.js": "2c51f647db3f36a1868607681fab06eb",
"main.dart.js_54.part.js": "ec7b85a2b9a7f0281a27bf03d73106b9",
"main.dart.js_38.part.js": "2d7251067b662a8865e2d6f3ee1a8890",
"main.dart.js_74.part.js": "fd4ad17d07ed1d165b755627178e2d54",
"main.dart.js_96.part.js": "96f43188faf98c2bb468cba2338f1cc2",
"main.dart.js_81.part.js": "21530b3bfa2562b3409414bb479e0327",
"main.dart.js_19.part.js": "4d5d9438aa76e54feabfbedd91e91ee5",
"main.dart.js_18.part.js": "aeae871ffef30651a1f991cc2570a8d9",
"main.dart.js_84.part.js": "22dd70652b9e140dec143fc81461b307",
"main.dart.js_42.part.js": "990343e5fa75578d996836043058977e",
"main.dart.js_55.part.js": "5b0fd9600fc26489f642b21499c7a191",
"main.dart.js_44.part.js": "b6a4091311ca4e73a7fcb5e079fe0669",
"main.dart.js_65.part.js": "7161e5e6ab84d3d8070186d6f7513f9a",
"main.dart.js_72.part.js": "3fd91d8669a1ab176ee1dfd46f5e9705",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"main.dart.js_77.part.js": "a6bc2e695b63f2fa0375132ee2975803",
"main.dart.js_85.part.js": "14a9e4e1831091dfb3ab8902c74d64c9",
"main.dart.js_59.part.js": "ab32525d97ef0a09350f83b10c8d6ec6",
"main.dart.js_94.part.js": "ab380566914f6a637db90ba74b80f9fb",
"main.dart.js_89.part.js": "1d8d2f42b0cf8ef58f0a5f39ffd652f2",
"main.dart.js_70.part.js": "cfd1795ea984ee9e7735772597cf0a85",
"main.dart.js_33.part.js": "d69d2310826b691d73065eeed57624b4",
"flutter.js": "83d881c1dbb6d6bcd6b42e274605b69c",
"main.dart.js_58.part.js": "f6ed718074b9dacddb785cfa3ed0f51e",
"main.dart.js_48.part.js": "d53114938e669237a9512cf0c8d646dd",
"main.dart.js_92.part.js": "f3b1546c9fe7e7f1283c85cbaedc4541",
"main.dart.js_104.part.js": "2fcf4b8ab171588199312e0c792e715c",
"main.dart.js_11.part.js": "7c4f2316a0d956d3ba6d7c0028b2c785",
"index.html": "2c5bb45b65a51a887d2f33b17bbfac0a",
"/": "2c5bb45b65a51a887d2f33b17bbfac0a",
"main.dart.js_4.part.js": "f63f0d1a4f7098e35997041f267d0d5e",
"main.dart.js_97.part.js": "1bb9cfaf3c68d92104581bebfa7d75bf",
"main.dart.js_26.part.js": "64755a1bc8d55fd09238581b455c9ecd",
"main.dart.js_47.part.js": "e272e26cfbeee2f5938b8efd99fd8362",
"main.dart.js_37.part.js": "24ee10b149e34fc1beff4b9835e32854",
"main.dart.js_27.part.js": "b889848802f702e5a967d497d301cb61",
"main.dart.js_99.part.js": "45ab355bdbcec9fd6c8592d4f8e5b5fa",
"main.dart.js_13.part.js": "8a03ad188453282b018e3cd7f1096348",
"main.dart.js_43.part.js": "9a1b83258a110bb9601495d03cd1c2ef",
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
"main.dart.js_23.part.js": "0459536f75fc5a05b9c458796ba61046",
"main.dart.js_67.part.js": "8fcb0ff0333a2b6f83e14335a040841d",
"main.dart.js_69.part.js": "e8009d843865e1dea63962f63a602800",
"main.dart.js_100.part.js": "4b4af9fcede1f3ccf2360cd2ee6264e7",
"manifest.json": "f41a1bcf7dd669f69c5758ad491dac0c",
"main.dart.js_90.part.js": "167e8331ef9cccc78d2b52672562920b",
"main.dart.js_52.part.js": "9ce0bead0ddd00c628ae0c4a78f7346f",
"main.dart.js_95.part.js": "51bc183a50f024b30118b20b194a697d",
"version.json": "6b8b9140b83c40f85633ddfcd9f81cd7",
"main.dart.js_2.part.js": "90e2d7ad8c433f8f48ca1652a6f12be4",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"main.dart.js_56.part.js": "ecba4215c0a33c770d84ccae4fef42cc",
"main.dart.js_80.part.js": "d42dc8e5af1a142746caa5e6d633c4dc",
"main.dart.js_12.part.js": "963c809453292df418b834cba96c6e32"};
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
