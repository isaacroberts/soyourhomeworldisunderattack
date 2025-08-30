'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"main.dart.js": "6d6f3e176063c0443b86727d9f6adcc3",
"main.dart.js_98.part.js": "092c684fa869fd32abd2db4c66f02eb3",
"main.dart.js_66.part.js": "686080ce8b5e3e6fddc9d9eb546a5c55",
"main.dart.js_63.part.js": "458415493665fd7be594eef2c26bd54f",
"main.dart.js_32.part.js": "b0044b476b936f41ec49ac30224cb069",
"main.dart.js_75.part.js": "530b1faac1e40e0d7672ed3e66b5b068",
"main.dart.js_9.part.js": "ee63a41451739154d7b5f1e62cc5564e",
"flutter_bootstrap.js": "3e7a515098b67de77eb437ffa0256887",
"main.dart.js_61.part.js": "1749659e59d20fcdeac8510ca1c15601",
"main.dart.js_64.part.js": "f0ae320d7e70b7f385bb945296ece571",
"main.dart.js_60.part.js": "3d616060c6a08bd7bd25e4392dba0e59",
"main.dart.js_102.part.js": "d3a8bd009302d397b59136c8ecd0657b",
"main.dart.js_76.part.js": "48c3060acfe14b37a7f816fec164d518",
"main.dart.js_106.part.js": "d2a2ccdb1969e8cc206b057a417f7cce",
"main.dart.js_62.part.js": "b697c171b751b79ecd943b88954358ad",
"main.dart.js_68.part.js": "c19647e85dfd7eb8b0e27b7b11344ccd",
"main.dart.js_83.part.js": "312f3a00b48f71c83dbc2f6fb8e1e827",
"canvaskit/canvaskit.js.symbols": "bdcd3835edf8586b6d6edfce8749fb77",
"canvaskit/canvaskit.wasm": "7a3f4ae7d65fc1de6a6e7ddd3224bc93",
"canvaskit/chromium/canvaskit.js.symbols": "b61b5f4673c9698029fa0a746a9ad581",
"canvaskit/chromium/canvaskit.wasm": "f504de372e31c8031018a9ec0a9ef5f0",
"canvaskit/chromium/canvaskit.js": "8191e843020c832c9cf8852a4b909d4c",
"canvaskit/skwasm.wasm": "39dd80367a4e71582d234948adc521c0",
"canvaskit/skwasm.js.symbols": "e72c79950c8a8483d826a7f0560573a1",
"canvaskit/canvaskit.js": "728b2d477d9b8c14593d4f9b82b484f3",
"canvaskit/skwasm.js": "ea559890a088fe28b4ddf70e17e60052",
"main.dart.js_79.part.js": "7d736986a0dd7ea1e0871d54806c70f8",
"main.dart.js_71.part.js": "2a1b9913a137c1a4b7147f056e62e40e",
"main.dart.js_41.part.js": "3aeb99757c32e0f02d651b1ec8c74028",
"main.dart.js_50.part.js": "666dd7c9b0b906d35dd73cac6fac73f6",
"main.dart.js_40.part.js": "f1492d845ef818127a4e0fa27e00fcf0",
"main.dart.js_113.part.js": "5bf0940aacc2157208bf922998802b0c",
"main.dart.js_30.part.js": "f29fe32174313187178f39c8b243feb2",
"main.dart.js_51.part.js": "f6ec00700d898f8bbcbde9759b04fc07",
"main.dart.js_28.part.js": "c8992c4b220010363c34aa4727c8ae9b",
"main.dart.js_29.part.js": "7600b5e56931a64c3f23d11d7a81c26a",
"main.dart.js_7.part.js": "fbd241cb5797900f57d65d28fa12bc4f",
"main.dart.js_91.part.js": "ccdf612f3b97b5ccf7dda589ece2c814",
"main.dart.js_8.part.js": "83bf4f4784c8ebfc81740c967f35d3bf",
"main.dart.js_25.part.js": "5931f25aba6cb9d28086e4f28c89b2d6",
"main.dart.js_103.part.js": "f1e9b20944cc890407ce7cce685cd2a1",
"main.dart.js_1.part.js": "61f77f3e9c75c39ea7428c470d6b345e",
"main.dart.js_3.part.js": "b0abf8950e23d94f28e8b82f4951e108",
"main.dart.js_34.part.js": "b181aa56da6be6e3dc140904c482cbe2",
"main.dart.js_22.part.js": "24df11f48b147198ced0611ea69b13a1",
"main.dart.js_14.part.js": "e0c318348e8a5173b07651c967777bde",
"main.dart.js_49.part.js": "87647b53e03c214c62e5d40005fa6988",
"main.dart.js_20.part.js": "5da749f633fdfc17c831de16a8fbcda6",
"main.dart.js_105.part.js": "5f9b78a1b1bd5dae980eb3c830cf0a3d",
"main.dart.js_6.part.js": "aecb86b924d70272787a4d0d504ee7c1",
"main.dart.js_87.part.js": "33eb7d823c06dc1b1c65ee51e8893375",
"main.dart.js_46.part.js": "280a4731ab8151b879b13b522a25bd05",
"main.dart.js_16.part.js": "5c029691882da12005c869120df754a9",
"main.dart.js_5.part.js": "b20eb72e914ab5cd51028a68f1a9af48",
"main.dart.js_57.part.js": "a414171bee83dd13523b7557f2b720eb",
"main.dart.js_82.part.js": "5a56f23422aaf1ae62718e678a589764",
"main.dart.js_17.part.js": "3d0fe44a91938dea41f9a94af97f572a",
"main.dart.js_36.part.js": "0774385a740d3b517be8f7756fda1804",
"main.dart.js_15.part.js": "d5dcbe26586257baf01a90ac159d6aac",
"main.dart.js_31.part.js": "b44ae2585fd198bbb04be5d92a8a0d98",
"main.dart.js_21.part.js": "ba8e09db3cc242ad8aa561df4f1375b5",
"main.dart.js_10.part.js": "01c7409f6e0ea73afc11d74cd389e468",
"main.dart.js_73.part.js": "764c6aa0f84215325a6d267ca3cfc5e4",
"main.dart.js_93.part.js": "555ebe58558ce6850cf5a4fe46106745",
"main.dart.js_115.part.js": "bd46d8f45cb6d958dfed7d1d32674633",
"main.dart.js_54.part.js": "d57d90571a7872912df04cea03b71bfa",
"main.dart.js_38.part.js": "bdf65853ad6c3a183458a3096a23cf6c",
"main.dart.js_116.part.js": "02cba299246c6fe15c683c52eae4253f",
"main.dart.js_74.part.js": "6e45174bad443fe617ce950b35c3e078",
"main.dart.js_53.part.js": "0e2be1cbf089a3ee735941929d945b3c",
"main.dart.js_96.part.js": "1c0f65bfc996bff016587c4ac1d44fa9",
"main.dart.js_81.part.js": "b4b1bf9067a3a9db929375dbbce1bff1",
"main.dart.js_19.part.js": "2febef711e06c6f10526ea98372425bc",
"main.dart.js_18.part.js": "e777ac2e351a0aa609b217c4488f25a9",
"main.dart.js_84.part.js": "a912113c6b166a5030e0da1f61fb9694",
"main.dart.js_42.part.js": "a807d0a5da05db20c8b7f376102cf2fd",
"main.dart.js_55.part.js": "acc1d9df62d07f7d50933b77a3d8e637",
"main.dart.js_107.part.js": "71be0519ca19acab870a3c1228f99372",
"main.dart.js_44.part.js": "77537eaa9fca9854867e9f4f9780ff17",
"main.dart.js_65.part.js": "91103d717a7a3d2f9ed37246d111118c",
"main.dart.js_72.part.js": "3f1dcd909b4c4a29a494cd8b4563f52a",
"icons/Icon-maskable-512.png": "274a1e917760a1f046d666e6202d023a",
"icons/Icon-maskable-96.png": "91ebf99f57762a0a291d74ca8992d18c",
"icons/Icon-maskable-128.png": "246028210ed2ad790833d9bae1456df3",
"icons/Icon-192.png": "de2ec02df3a1869af4ad786b508d58d0",
"icons/Icon-maskable-192.png": "0bf4a53e4bdef76509c1639561988a14",
"icons/Icon-512.png": "80a96cdf564eb56bf72144a81d528408",
"main.dart.js_77.part.js": "b4cad97a9c2507dcb54f5d5170737ca2",
"main.dart.js_85.part.js": "1661711682b773e06341abff29dffdf1",
"main.dart.js_108.part.js": "9e97014a9296f044e89162e38ba7a9b1",
"main.dart.js_59.part.js": "449a2e1d37fb9cb208746c35922ca536",
"main.dart.js_94.part.js": "e945643a80b4eda6144bd514b69dba4e",
"main.dart.js_89.part.js": "88c8bdfedf2f5d45cba68032683cd427",
"main.dart.js_70.part.js": "d5772394fcf53b06557596b073f57dc3",
"main.dart.js_33.part.js": "f7e907affa8e8e3c5d812ff9c1a7236b",
"flutter.js": "83d881c1dbb6d6bcd6b42e274605b69c",
"main.dart.js_58.part.js": "5f79ea86cee600649a8de5b461f3a606",
"main.dart.js_24.part.js": "cd1aeefec82c7cad2795a87847b52476",
"main.dart.js_48.part.js": "ace27a93b0b39a525b840570f847f9ec",
"main.dart.js_92.part.js": "3a6194b233f1aca3934617c9c87a5611",
"main.dart.js_110.part.js": "b9957b90ce71300d73957b05ab129907",
"main.dart.js_104.part.js": "373201dfd1d26f7b5fd894c3114158dc",
"main.dart.js_11.part.js": "89531ccf4262256070bdee8bb7f9ba3e",
"index.html": "03563f3989cddd6c542d2256590bb1a8",
"/": "03563f3989cddd6c542d2256590bb1a8",
"main.dart.js_4.part.js": "06233ccb4578e1c4ba235afd69346f95",
"main.dart.js_97.part.js": "8183019676ced6337f5f49caa14acb72",
"main.dart.js_26.part.js": "b6b5f5dfcd8bd76107a4286fe32b7293",
"main.dart.js_47.part.js": "7db4a5948d0cfbfad2ae40ad7ab4f22e",
"main.dart.js_37.part.js": "369b0728d9c57625bd4d2281fddd68a0",
"main.dart.js_27.part.js": "59a5b154944e74fd205632aeaba8f0df",
"main.dart.js_99.part.js": "9f8024931fad5da7a312eacbc91c9b9e",
"main.dart.js_13.part.js": "48c1fea88d3f1a66bb93c1c14a3c9944",
"main.dart.js_112.part.js": "c108338881f27fc9d87250bb5cc348d5",
"main.dart.js_43.part.js": "b70b80f25bb28178a6581ce53a308fe9",
"main.dart.js_39.part.js": "dc1e84c65f53bcdd89707924ace2c169",
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
"main.dart.js_88.part.js": "77cb472006643040b9cb3c5ba54413d0",
"main.dart.js_23.part.js": "88e908211e036b8af516116a2b44e49c",
"main.dart.js_67.part.js": "e1374aa85fb113c2cd0eeb923cf41d4a",
"main.dart.js_111.part.js": "72d43f155577e1171f4c61ce729767a3",
"main.dart.js_114.part.js": "e4ebe44e14bb038f28eb8e08fea6c982",
"main.dart.js_69.part.js": "d2f70ba97ad72632f3399cb8b4429a7b",
"main.dart.js_100.part.js": "129b9600b80a1136d42a62394e10f2cb",
"manifest.json": "38212b39dd51df343b19bfa938e9ac4f",
"main.dart.js_78.part.js": "b34a6602547ec07396c39f47e0dc31f2",
"main.dart.js_90.part.js": "4f7bb39096adc2737e0fcabdeac654cf",
"main.dart.js_35.part.js": "ce1ba5990b72b970795880bee83965f4",
"main.dart.js_52.part.js": "1c57f7f758140e5edc1e5b5f20c66445",
"main.dart.js_95.part.js": "63bde77155c513da28ff09c1fb8a6c67",
"version.json": "6b8b9140b83c40f85633ddfcd9f81cd7",
"main.dart.js_109.part.js": "2525151fa65f9b469de9c898e4d96d0a",
"main.dart.js_2.part.js": "8035fdfcc808a996177da5ee61c97c59",
"favicon.png": "306e7ba8f0872a8ae25be6aca7d80b7f",
"main.dart.js_45.part.js": "e6bdf98da628a1a6c6a4c1a89336a9e5",
"main.dart.js_56.part.js": "9c15f58c0a0fff4759fdbc6ccf990699",
"main.dart.js_80.part.js": "d5333853e3cfdcf37fbfb7c50175c69c",
"main.dart.js_86.part.js": "632be6190e279b8fd56fd93db42d4bee",
"main.dart.js_12.part.js": "59cd1c942717644bde275d6e4415d857"};
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
