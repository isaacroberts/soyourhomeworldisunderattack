'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"main.dart.js": "3014ebd6e5bf30d39f3f643a324cd2b3",
"main.dart.js_98.part.js": "092c684fa869fd32abd2db4c66f02eb3",
"main.dart.js_66.part.js": "1302d73c02613fc96d5d66bd08f675ad",
"main.dart.js_63.part.js": "9e99d4ed63efe2fb832d6f4941770ba0",
"main.dart.js_32.part.js": "9bf4e56be2f1cb50d41cf476486cdb1e",
"main.dart.js_75.part.js": "773178f5991c0aa850930df04267b1fe",
"main.dart.js_9.part.js": "c4385f13c6766a1ccf54f156c1927519",
"flutter_bootstrap.js": "f007281ee622871b2ecdf2e6fb0a6bce",
"main.dart.js_61.part.js": "4751f060a100b77bd306089d28d3d0cf",
"main.dart.js_64.part.js": "6aeb21425a8a1eb5c2e9211873086fe5",
"main.dart.js_60.part.js": "756320e69758ce36e2128c599223793d",
"main.dart.js_102.part.js": "d3a8bd009302d397b59136c8ecd0657b",
"main.dart.js_76.part.js": "52306e6f1de43a1ebd43950ef8968f75",
"main.dart.js_106.part.js": "d2a2ccdb1969e8cc206b057a417f7cce",
"main.dart.js_62.part.js": "d6eeade8ec5ce971e58d9bf0342d9d07",
"main.dart.js_68.part.js": "6ac5774a93b535daa01b8eaf4879ce0b",
"main.dart.js_83.part.js": "0b48b5be23460051cf73293edc213eb4",
"canvaskit/canvaskit.js.symbols": "bdcd3835edf8586b6d6edfce8749fb77",
"canvaskit/canvaskit.wasm": "7a3f4ae7d65fc1de6a6e7ddd3224bc93",
"canvaskit/chromium/canvaskit.js.symbols": "b61b5f4673c9698029fa0a746a9ad581",
"canvaskit/chromium/canvaskit.wasm": "f504de372e31c8031018a9ec0a9ef5f0",
"canvaskit/chromium/canvaskit.js": "8191e843020c832c9cf8852a4b909d4c",
"canvaskit/skwasm.wasm": "39dd80367a4e71582d234948adc521c0",
"canvaskit/skwasm.js.symbols": "e72c79950c8a8483d826a7f0560573a1",
"canvaskit/canvaskit.js": "728b2d477d9b8c14593d4f9b82b484f3",
"canvaskit/skwasm.js": "ea559890a088fe28b4ddf70e17e60052",
"main.dart.js_79.part.js": "6881978f68186e44a03ae2c267ec67b7",
"main.dart.js_71.part.js": "bf698627efd482474079a4cb4347fce7",
"main.dart.js_41.part.js": "f91cf27e325c53ad5358745e4aa2e6b9",
"main.dart.js_50.part.js": "b63e0ae940874c69273b5aeddea2d772",
"main.dart.js_40.part.js": "326fe3a437d005fabc80141e64f0d042",
"main.dart.js_113.part.js": "5bf0940aacc2157208bf922998802b0c",
"main.dart.js_30.part.js": "5f5d58024f23ca55e6d6c406746f07b2",
"main.dart.js_51.part.js": "0c9af8b6510b14766d0f61228554d1a2",
"main.dart.js_28.part.js": "c50b191a4f354ed44ceaabdd3efb0a22",
"main.dart.js_29.part.js": "12c238950a3db845e0b7a523178e2721",
"main.dart.js_7.part.js": "b665b38537f5bd4785d3f26d494c96a2",
"main.dart.js_91.part.js": "4bb0889d8f8f05b1227b16ce70bbfdcb",
"main.dart.js_8.part.js": "52a9b73142db63bc0c91eb2558e6eb16",
"main.dart.js_25.part.js": "cf029e9762becb3af5fefc163b971efc",
"main.dart.js_103.part.js": "f1e9b20944cc890407ce7cce685cd2a1",
"main.dart.js_1.part.js": "c1967dd2adc1013dccb7c20c366ffbf3",
"main.dart.js_3.part.js": "e90f0f91f1a3445cc7ad35e291a22348",
"main.dart.js_34.part.js": "8db8af0bfdb06479c92e97fb1c446b52",
"main.dart.js_22.part.js": "4f106e4cbb950c5b5ea1a5e4a0e0dc07",
"main.dart.js_14.part.js": "b05c2c88f880706defeb550e7bd0038b",
"main.dart.js_49.part.js": "b6a39c682f68276e39921bae3a1ee1a4",
"main.dart.js_20.part.js": "5da749f633fdfc17c831de16a8fbcda6",
"main.dart.js_105.part.js": "5f9b78a1b1bd5dae980eb3c830cf0a3d",
"main.dart.js_6.part.js": "60776ec61ad338eb0421a97d76925170",
"main.dart.js_87.part.js": "cebc520c61b8257514ec48ec06871185",
"main.dart.js_46.part.js": "83006cba8b57e18717aa49432f4313d1",
"main.dart.js_16.part.js": "577af931341ffd9b58dc665bafad7a09",
"main.dart.js_5.part.js": "3d7faa2d1341af6c19e957856866cda0",
"main.dart.js_57.part.js": "083e611dc12df11a5a70eb040a6401eb",
"main.dart.js_82.part.js": "6424935962173d7c7a69d15a742c181d",
"main.dart.js_17.part.js": "3d0fe44a91938dea41f9a94af97f572a",
"main.dart.js_36.part.js": "9df00476de76fd0cbacbeb772abf92f9",
"main.dart.js_15.part.js": "ebb17b7a76ac9102609c748cc39033fe",
"main.dart.js_31.part.js": "48e2f77567ecba43fe058cdaf16b4829",
"main.dart.js_21.part.js": "6d29fe46c156a725944cf5d5c833931e",
"main.dart.js_10.part.js": "efb91996a4faf88293ecaf26591fd750",
"main.dart.js_73.part.js": "b9ebfd730a4b03e94c41ae17b907b826",
"main.dart.js_93.part.js": "7e5c65d3a95d8328611ddd01b027c72d",
"main.dart.js_115.part.js": "bd46d8f45cb6d958dfed7d1d32674633",
"main.dart.js_54.part.js": "2253fbca0b6cd09683ca6e0c698e429d",
"main.dart.js_38.part.js": "0bdc4188961a1946aeecf023b7980902",
"main.dart.js_116.part.js": "02cba299246c6fe15c683c52eae4253f",
"main.dart.js_74.part.js": "87889f5c09ddf1af298d548f1f967d62",
"main.dart.js_53.part.js": "2ea944a026e3c21216a1e598556f31c2",
"main.dart.js_96.part.js": "1c0f65bfc996bff016587c4ac1d44fa9",
"main.dart.js_81.part.js": "4c76307d1b43fc2658433602805cd04e",
"main.dart.js_19.part.js": "1657fbbeccc467c57e34a8967b9b8e8f",
"main.dart.js_18.part.js": "40cd503de011904daa81c020bc188e29",
"main.dart.js_84.part.js": "32eb8e5f322ce212b6a4e5096c5e7616",
"main.dart.js_42.part.js": "b9010768056cc614067ce5993d0197e3",
"main.dart.js_55.part.js": "56bfde19a1712bf7741c4fa545574df4",
"main.dart.js_107.part.js": "71be0519ca19acab870a3c1228f99372",
"main.dart.js_44.part.js": "743cb39528ab18f890e261968e981dc0",
"main.dart.js_65.part.js": "c7617f6064233b54233b8445c3ce1179",
"main.dart.js_72.part.js": "197c8deff2937d30b37a713cfdbca7a7",
"icons/Icon-maskable-512.png": "274a1e917760a1f046d666e6202d023a",
"icons/Icon-maskable-96.png": "91ebf99f57762a0a291d74ca8992d18c",
"icons/Icon-maskable-128.png": "246028210ed2ad790833d9bae1456df3",
"icons/Icon-192.png": "de2ec02df3a1869af4ad786b508d58d0",
"icons/Icon-maskable-192.png": "0bf4a53e4bdef76509c1639561988a14",
"icons/Icon-512.png": "80a96cdf564eb56bf72144a81d528408",
"main.dart.js_77.part.js": "9b52cbe452edb4cacc1de98b09d783f1",
"main.dart.js_85.part.js": "9dfc49bc27df6e20cea52d28448a0ce0",
"main.dart.js_108.part.js": "9e97014a9296f044e89162e38ba7a9b1",
"main.dart.js_59.part.js": "b044d47efc44aca2d99d81ecdca0067e",
"main.dart.js_94.part.js": "eff5ee87888953b937afcbfb77bf56cb",
"main.dart.js_89.part.js": "9bc65522cb2c63ef2bb57a4a4626f252",
"main.dart.js_70.part.js": "d4c5d747e8b8402cbf4d4322ed875d64",
"main.dart.js_33.part.js": "aa008a32e8f0effe08bb9e46cb5c8f34",
"flutter.js": "83d881c1dbb6d6bcd6b42e274605b69c",
"main.dart.js_58.part.js": "9e9f43ddde9344063ad6fb9f082f3147",
"main.dart.js_24.part.js": "e90e8d350307a7d4fb6a6a54afdcf403",
"main.dart.js_48.part.js": "f69d2c8e04a86127ee53da3b33f16936",
"main.dart.js_92.part.js": "d034da6b3a1c5d2a08f51186d499d84a",
"main.dart.js_110.part.js": "b9957b90ce71300d73957b05ab129907",
"main.dart.js_104.part.js": "373201dfd1d26f7b5fd894c3114158dc",
"main.dart.js_11.part.js": "507c9241d131b7996d9b0a3a5155a9ec",
"index.html": "2c5bb45b65a51a887d2f33b17bbfac0a",
"/": "2c5bb45b65a51a887d2f33b17bbfac0a",
"main.dart.js_4.part.js": "11193feaa81df7c58f32f736ee0066eb",
"main.dart.js_97.part.js": "8183019676ced6337f5f49caa14acb72",
"main.dart.js_26.part.js": "405c7e1f60ba25797c0831ebbccee558",
"main.dart.js_47.part.js": "20a58b6871691dffa913d4331b1c45f2",
"main.dart.js_37.part.js": "f89b78188e306751ecb86fb6c754a88c",
"main.dart.js_27.part.js": "675c94635854e515ef7b5b37ce3e5907",
"main.dart.js_99.part.js": "9f8024931fad5da7a312eacbc91c9b9e",
"main.dart.js_13.part.js": "6367fa96fada418df37dd2d692a8cf62",
"main.dart.js_112.part.js": "c108338881f27fc9d87250bb5cc348d5",
"main.dart.js_43.part.js": "0b64a82dbbf4051eb4b69093f7351917",
"main.dart.js_39.part.js": "6787917968dd4df3e1ea13a4a14f4c22",
"assets/AssetManifest.bin": "cd5d7abf98054bdf8a9d1c8eb941fcd0",
"assets/cargoship/iconttf/RpgAwesome.ttf": "3fb8d0aa42860e8db819f5d3c65834c5",
"assets/cargoship/builtin_fonts/Palatino_bold.ttf": "975972a205fd91a532d1b7433281af70",
"assets/cargoship/builtin_fonts/Palatino_italic.ttf": "be4590eba976dace111b6686f6dade52",
"assets/cargoship/builtin_fonts/Rubik-VariableFont_wght.ttf": "6d3102fa33194bef395536d580f91b56",
"assets/cargoship/builtin_fonts/Palatino_roman.ttf": "96261bb90c9babbf8042ce7f43200d65",
"assets/cargoship/builtin_fonts/Palatino_bolditalic.ttf": "beef66370e7124eb683514ad9ad07576",
"assets/AssetManifest.bin.json": "50204dc89005b799bf8b48ba16a1d3d7",
"assets/fonts/MaterialIcons-Regular.otf": "e8a888495894017772eef6730b7fcb69",
"assets/FontManifest.json": "3002a5264f22544b5ff394355b0605d5",
"assets/AssetManifest.json": "845139c6a2d4e9245bbe46e978b2be42",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/NOTICES": "9c1692f49e2646eac51f22def6eece56",
"main.dart.js_88.part.js": "904f335e79ef1d9a49ffa6af25617576",
"main.dart.js_23.part.js": "6d56e0bb4f354c107baadba56516bf9e",
"main.dart.js_67.part.js": "889a80c152d4be3aad67644880513c5f",
"main.dart.js_111.part.js": "72d43f155577e1171f4c61ce729767a3",
"main.dart.js_114.part.js": "e4ebe44e14bb038f28eb8e08fea6c982",
"main.dart.js_69.part.js": "ba96d93123de10c3725d8c1341931cc5",
"main.dart.js_100.part.js": "129b9600b80a1136d42a62394e10f2cb",
"manifest.json": "f41a1bcf7dd669f69c5758ad491dac0c",
"main.dart.js_78.part.js": "f774041e23970d82a2216bedf488bc81",
"main.dart.js_90.part.js": "e891241ee037076c906b577f1351d4a2",
"main.dart.js_35.part.js": "9ccb85957b81dfebc1110638bb334899",
"main.dart.js_52.part.js": "c8024bc9875be7705e323dae110a8c97",
"version.json": "6b8b9140b83c40f85633ddfcd9f81cd7",
"main.dart.js_109.part.js": "2525151fa65f9b469de9c898e4d96d0a",
"main.dart.js_2.part.js": "8af7e521e83f5454c263c6ddaece3d9b",
"favicon.png": "306e7ba8f0872a8ae25be6aca7d80b7f",
"main.dart.js_45.part.js": "e6bdf98da628a1a6c6a4c1a89336a9e5",
"main.dart.js_56.part.js": "eef66be35797165551546324e6a21d9d",
"main.dart.js_80.part.js": "1fb2753eef7d30f390982ed4480baca7",
"main.dart.js_86.part.js": "168626afb094433d36e1f748281b2464",
"main.dart.js_12.part.js": "76ed9dc39fad01299c474071311ba44b"};
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
