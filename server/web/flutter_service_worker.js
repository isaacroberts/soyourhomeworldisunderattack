'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"main.dart.js": "f318b63074ec101d0ee8bc4b92f98cbf",
"main.dart.js_98.part.js": "092c684fa869fd32abd2db4c66f02eb3",
"main.dart.js_66.part.js": "379e1915310a6987e4c8432b19d58ec0",
"main.dart.js_63.part.js": "4671599c51a7fe419dd2a90068a3ae7d",
"main.dart.js_32.part.js": "d138ad6d6566ae661c663488b7116615",
"main.dart.js_75.part.js": "d1a0044fc39be3b3842d2c174c6ef118",
"main.dart.js_9.part.js": "21cf22c2ea347dce5154f2b8d17dfd95",
"flutter_bootstrap.js": "479161449ab5c2ab48c92d1acd246eba",
"main.dart.js_61.part.js": "00c89e7d2c2838542ec37081b05d9575",
"main.dart.js_64.part.js": "790bdd03d77d16972102632cc9acb418",
"main.dart.js_60.part.js": "f9568041ded4dcfbbb27cdaa3f8a9a25",
"main.dart.js_102.part.js": "d3a8bd009302d397b59136c8ecd0657b",
"main.dart.js_76.part.js": "9a7ddfcc5c17ece53c0f0c22cb13b4d4",
"main.dart.js_106.part.js": "d2a2ccdb1969e8cc206b057a417f7cce",
"main.dart.js_62.part.js": "9b13a3481fe4201c56b07a4fab38e826",
"main.dart.js_68.part.js": "5f88b70a43e0b58363972de474be08f4",
"main.dart.js_83.part.js": "51950958f8e090f5d5058d4923c983e2",
"canvaskit/canvaskit.js.symbols": "bdcd3835edf8586b6d6edfce8749fb77",
"canvaskit/canvaskit.wasm": "7a3f4ae7d65fc1de6a6e7ddd3224bc93",
"canvaskit/chromium/canvaskit.js.symbols": "b61b5f4673c9698029fa0a746a9ad581",
"canvaskit/chromium/canvaskit.wasm": "f504de372e31c8031018a9ec0a9ef5f0",
"canvaskit/chromium/canvaskit.js": "8191e843020c832c9cf8852a4b909d4c",
"canvaskit/skwasm.wasm": "39dd80367a4e71582d234948adc521c0",
"canvaskit/skwasm.js.symbols": "e72c79950c8a8483d826a7f0560573a1",
"canvaskit/canvaskit.js": "728b2d477d9b8c14593d4f9b82b484f3",
"canvaskit/skwasm.js": "ea559890a088fe28b4ddf70e17e60052",
"main.dart.js_79.part.js": "84d3f0ba716472abb7ba3c7cb45f4ff7",
"main.dart.js_71.part.js": "5c07976c47674f507e353f62897b7091",
"main.dart.js_41.part.js": "6e83cba65784da1a401cb58b56ff0b5c",
"main.dart.js_50.part.js": "c791fcb6c48c797d2fd57a1cda6b1f64",
"main.dart.js_40.part.js": "04eb09a0e842584bb0dd64540232f889",
"main.dart.js_113.part.js": "5bf0940aacc2157208bf922998802b0c",
"main.dart.js_30.part.js": "59940024e60313fccda22113a70ff920",
"main.dart.js_51.part.js": "37af3aefbba4f03191bf28b984941b27",
"main.dart.js_28.part.js": "10807e8414af7667d2d78ad8b3fc8e72",
"main.dart.js_29.part.js": "3050106592893b9a5ce96724534a91c0",
"main.dart.js_7.part.js": "59c061d4c29ee590bc6506b794adae9e",
"main.dart.js_91.part.js": "92189d220fe4d4289e2caddb54f7c922",
"main.dart.js_8.part.js": "0986abe2bd269315abe0c99e9ed86dfa",
"main.dart.js_25.part.js": "7ee208f8c92971d698cf22c57add345a",
"main.dart.js_103.part.js": "f1e9b20944cc890407ce7cce685cd2a1",
"main.dart.js_1.part.js": "6d60f3efad2d226a97ab1a6b361b60da",
"main.dart.js_3.part.js": "214afeb5cc07d2c5445aee34ff4104d3",
"main.dart.js_34.part.js": "3e8302ea8c6412bb46dde097ff8f9710",
"main.dart.js_22.part.js": "97435402c14a7dd22161c3e5a80290c1",
"main.dart.js_14.part.js": "ba5af4abc8370e826578e8baffd7efea",
"main.dart.js_49.part.js": "8436adae494dc1a6536aa1c154acf5ab",
"main.dart.js_20.part.js": "0b125b756ab75156c966f9029bb41206",
"main.dart.js_105.part.js": "5f9b78a1b1bd5dae980eb3c830cf0a3d",
"main.dart.js_6.part.js": "eb6a380a451a21354b4c34d63b2d083b",
"main.dart.js_87.part.js": "818f3320331587a685117005e5aaa4db",
"main.dart.js_46.part.js": "5d8e0809176bbc3d98b5243d52fed31f",
"main.dart.js_16.part.js": "d9845776972ac3df9f6ee55dcb765ea2",
"main.dart.js_5.part.js": "348f2adc159a5c1d97301777aff6054e",
"main.dart.js_57.part.js": "acd3f384a0eccefc9ff45514665e7018",
"main.dart.js_82.part.js": "3d87b14f3252b5eb6db5028f5cef6448",
"main.dart.js_17.part.js": "de0a951dfb33c6e57f06f78133c440b4",
"main.dart.js_36.part.js": "0ae383ca029afcdc0c2358cf56819367",
"main.dart.js_15.part.js": "5103d09c84bbcaf2ecb25242191d9a38",
"main.dart.js_31.part.js": "df365a5242e68299339764ccb3770823",
"main.dart.js_21.part.js": "7141b927161797023e9633358b7d1851",
"main.dart.js_10.part.js": "202b53c5de949b8c22e235c5e71d02f0",
"main.dart.js_73.part.js": "8aea865bfd6f9b1c20a591ddae1141ab",
"main.dart.js_93.part.js": "5cb94bc8979effbbf2619d0256eb4c5d",
"main.dart.js_115.part.js": "bd46d8f45cb6d958dfed7d1d32674633",
"main.dart.js_54.part.js": "167b14af638e5c5cf00c5e6444303b89",
"main.dart.js_38.part.js": "f5e9d057a5c67f258fcf8f1214cf9205",
"main.dart.js_116.part.js": "02cba299246c6fe15c683c52eae4253f",
"main.dart.js_74.part.js": "8f7a95880c35181f024f74e2d050f35c",
"main.dart.js_53.part.js": "c4235932520ca4fcb136bba7926ba420",
"main.dart.js_96.part.js": "3f1aa7f7e77c29fca3ea2d5e1e0e737c",
"main.dart.js_81.part.js": "2dc2d746b8a7649645aaeeb8f12c8270",
"main.dart.js_19.part.js": "89602fc2bad5f7b7875f80b0b7e0d787",
"main.dart.js_18.part.js": "df7a946da907a9e722775227f10539c7",
"main.dart.js_84.part.js": "c37c4fcaffeb3a60e5fc0ca45cecb047",
"main.dart.js_42.part.js": "0781ab6a5f25348c361053326fc35bc4",
"main.dart.js_55.part.js": "911f7cbe0e5b142a2de343eb39c22252",
"main.dart.js_107.part.js": "71be0519ca19acab870a3c1228f99372",
"main.dart.js_44.part.js": "392e584fd1a35c333beb0033bac709ae",
"main.dart.js_65.part.js": "a5dd56b720e67dfb33cd0d45477b9de8",
"main.dart.js_72.part.js": "7b4618c42a94e77601909d9e3e83ec96",
"icons/Icon-maskable-512.png": "274a1e917760a1f046d666e6202d023a",
"icons/Icon-maskable-96.png": "91ebf99f57762a0a291d74ca8992d18c",
"icons/Icon-maskable-128.png": "246028210ed2ad790833d9bae1456df3",
"icons/Icon-192.png": "de2ec02df3a1869af4ad786b508d58d0",
"icons/Icon-maskable-192.png": "0bf4a53e4bdef76509c1639561988a14",
"icons/Icon-512.png": "80a96cdf564eb56bf72144a81d528408",
"main.dart.js_77.part.js": "2f4d388d6c2cff5e9036a12cba3db557",
"main.dart.js_85.part.js": "be9825c2217fde02fea1dda977f6f4a9",
"main.dart.js_108.part.js": "9e97014a9296f044e89162e38ba7a9b1",
"main.dart.js_59.part.js": "d99668103e1073d834ee91a41816936e",
"main.dart.js_94.part.js": "6b0c9583c1e0c6dfc26c1599bede70fc",
"main.dart.js_89.part.js": "73adb973c140e11774d1f1d25013fb70",
"main.dart.js_70.part.js": "f0ed81353faf1ab22fbcd1b3606bbb2f",
"main.dart.js_33.part.js": "0c3b27cbc5fa6837a2cdae1098d20a5b",
"flutter.js": "83d881c1dbb6d6bcd6b42e274605b69c",
"main.dart.js_58.part.js": "6564737307133d5ec6d530da46694e0d",
"main.dart.js_24.part.js": "dfb65d62786f26eb5be3e3159fdff5cc",
"main.dart.js_48.part.js": "297c74c50e3cebb7d1ebfa0840ec4a86",
"main.dart.js_92.part.js": "e80bf5d11d41261af73f2bad4a494143",
"main.dart.js_110.part.js": "b9957b90ce71300d73957b05ab129907",
"main.dart.js_104.part.js": "373201dfd1d26f7b5fd894c3114158dc",
"main.dart.js_11.part.js": "f9a71d0c5dc08bb4d6bf337359a80eb9",
"index.html": "69aa3375e32d45576f2c3bf75da20a55",
"/": "69aa3375e32d45576f2c3bf75da20a55",
"main.dart.js_4.part.js": "8c935f94e961075d0c66d1df273711d1",
"main.dart.js_97.part.js": "8183019676ced6337f5f49caa14acb72",
"main.dart.js_26.part.js": "98c2f12b9be8f9dc6746649e6f662555",
"main.dart.js_47.part.js": "a2938d2feb6e9cf79fa8aef6280f9b23",
"main.dart.js_37.part.js": "6d5a8c40111817f7408cd356ee458a8b",
"main.dart.js_27.part.js": "760c77d1f53ab7096d04c485c5a4fffa",
"main.dart.js_99.part.js": "9f8024931fad5da7a312eacbc91c9b9e",
"main.dart.js_13.part.js": "6a1890f287cb3a18ee99db800e3c0712",
"main.dart.js_112.part.js": "c108338881f27fc9d87250bb5cc348d5",
"main.dart.js_43.part.js": "f893bf8516e092d50056d666237cb9c6",
"main.dart.js_39.part.js": "de219aa40c82eff4f0a6ca6b5094cf94",
"assets/AssetManifest.bin": "dc416fefc61bf6fa584419654e74b503",
"assets/cargoship/iconttf/RpgAwesome.ttf": "3fb8d0aa42860e8db819f5d3c65834c5",
"assets/cargoship/builtin_fonts/Palatino_bold.ttf": "975972a205fd91a532d1b7433281af70",
"assets/cargoship/builtin_fonts/Palatino_italic.ttf": "be4590eba976dace111b6686f6dade52",
"assets/cargoship/builtin_fonts/Rubik-VariableFont_wght.ttf": "6d3102fa33194bef395536d580f91b56",
"assets/cargoship/builtin_fonts/Palatino_roman.ttf": "96261bb90c9babbf8042ce7f43200d65",
"assets/cargoship/builtin_fonts/Palatino_bolditalic.ttf": "beef66370e7124eb683514ad9ad07576",
"assets/AssetManifest.bin.json": "a8d1fbe0cfd6cef18ceaf86bef6143b3",
"assets/fonts/MaterialIcons-Regular.otf": "9eabea08abc2724f421f58f2018e94b1",
"assets/FontManifest.json": "3002a5264f22544b5ff394355b0605d5",
"assets/AssetManifest.json": "15a1a820c6e9f5b070884b5d1b8d986e",
"assets/shaders/earth_shader.frag": "caf56930d35615fe17651639db897543",
"assets/shaders/simple.frag": "0c2299d2b35041e8ce02cbf2404d1a27",
"assets/shaders/continents.frag": "065e06a6d824796a063cecd71a94cc56",
"assets/shaders/clouds.frag": "3bd92841974db1d2e588a0e56e0b8dc1",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/NOTICES": "9c1692f49e2646eac51f22def6eece56",
"main.dart.js_88.part.js": "2a5a765c147f69c3b609062355a0c26e",
"main.dart.js_23.part.js": "be725d2d65834842d1220d8c2ff0a51b",
"main.dart.js_67.part.js": "40f928476398204e707212a64e1bf400",
"main.dart.js_111.part.js": "72d43f155577e1171f4c61ce729767a3",
"main.dart.js_114.part.js": "e4ebe44e14bb038f28eb8e08fea6c982",
"main.dart.js_69.part.js": "fe2f124b1f6db1028eb88d6942f7486a",
"main.dart.js_100.part.js": "129b9600b80a1136d42a62394e10f2cb",
"manifest.json": "38212b39dd51df343b19bfa938e9ac4f",
"main.dart.js_78.part.js": "373709861448047d989be429f9fb483c",
"main.dart.js_90.part.js": "2ff9afbf3690cb42d66bd572a151355a",
"main.dart.js_35.part.js": "4a50940c02e2cf4c52133a333805bc73",
"main.dart.js_52.part.js": "a93e0e471f942e2d926b373a693f8a7d",
"main.dart.js_95.part.js": "e6792afa16665120b43bf48baaeca4a7",
"version.json": "6b8b9140b83c40f85633ddfcd9f81cd7",
"main.dart.js_109.part.js": "2525151fa65f9b469de9c898e4d96d0a",
"main.dart.js_2.part.js": "5b5d60268e86462a85a5fff0e0d6bf3f",
"favicon.png": "306e7ba8f0872a8ae25be6aca7d80b7f",
"main.dart.js_45.part.js": "6c7f764534c5755e87d07d6adaa40061",
"main.dart.js_56.part.js": "f338be3929e919e5c6c4b183e2255439",
"main.dart.js_80.part.js": "c9afb1580153a33661243b32076a66b0",
"main.dart.js_86.part.js": "f23ddf874c72e1f201d4f1d754362bc2",
"main.dart.js_12.part.js": "46a91361474493587142abf7ae30b464"};
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
