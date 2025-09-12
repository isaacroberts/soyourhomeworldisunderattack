'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"main.dart.js": "b906987a352df5551c229dc0e24afc0f",
"main.dart.js_98.part.js": "092c684fa869fd32abd2db4c66f02eb3",
"main.dart.js_66.part.js": "a8a6f382a557444540749104b91a0da6",
"main.dart.js_63.part.js": "b7651c49dc862d8feee325a39fdd7879",
"main.dart.js_32.part.js": "27d8d8d2194ad2d9e7960abbfc63990a",
"main.dart.js_75.part.js": "38e29697a6ef50c9f31c4b70047c6ee3",
"main.dart.js_9.part.js": "21cf22c2ea347dce5154f2b8d17dfd95",
"flutter_bootstrap.js": "4370e9b86756d80524faefbfd8a6b8dd",
"main.dart.js_61.part.js": "f07ea25661153bca3f435ae36cffb7ea",
"main.dart.js_64.part.js": "bda9111df2680442e1cfc468809ee3b9",
"main.dart.js_60.part.js": "f9568041ded4dcfbbb27cdaa3f8a9a25",
"main.dart.js_102.part.js": "d3a8bd009302d397b59136c8ecd0657b",
"main.dart.js_76.part.js": "9a7ddfcc5c17ece53c0f0c22cb13b4d4",
"main.dart.js_106.part.js": "d2a2ccdb1969e8cc206b057a417f7cce",
"main.dart.js_62.part.js": "9b13a3481fe4201c56b07a4fab38e826",
"main.dart.js_68.part.js": "eb94f274306703fe2ce15a3f37673e21",
"main.dart.js_83.part.js": "6723c3f905a32e23198bfce560031305",
"canvaskit/canvaskit.js.symbols": "bdcd3835edf8586b6d6edfce8749fb77",
"canvaskit/canvaskit.wasm": "7a3f4ae7d65fc1de6a6e7ddd3224bc93",
"canvaskit/chromium/canvaskit.js.symbols": "b61b5f4673c9698029fa0a746a9ad581",
"canvaskit/chromium/canvaskit.wasm": "f504de372e31c8031018a9ec0a9ef5f0",
"canvaskit/chromium/canvaskit.js": "8191e843020c832c9cf8852a4b909d4c",
"canvaskit/skwasm.wasm": "39dd80367a4e71582d234948adc521c0",
"canvaskit/skwasm.js.symbols": "e72c79950c8a8483d826a7f0560573a1",
"canvaskit/canvaskit.js": "728b2d477d9b8c14593d4f9b82b484f3",
"canvaskit/skwasm.js": "ea559890a088fe28b4ddf70e17e60052",
"main.dart.js_79.part.js": "5c34404dd7accbf990d49b2751e4c81e",
"main.dart.js_71.part.js": "dd0b50658c7144d57d78cda7c9054cfa",
"main.dart.js_41.part.js": "bf33587627911519200e6936c8408b79",
"main.dart.js_50.part.js": "ec5a262746b602631546c6cbbece84fc",
"main.dart.js_40.part.js": "04eb09a0e842584bb0dd64540232f889",
"main.dart.js_113.part.js": "5bf0940aacc2157208bf922998802b0c",
"main.dart.js_30.part.js": "6b609f117bb15b430d69123a60746aae",
"main.dart.js_51.part.js": "37af3aefbba4f03191bf28b984941b27",
"main.dart.js_28.part.js": "03b3a7b43a27d6b5deac476421d6a417",
"main.dart.js_29.part.js": "f8a7664719dc5f6921b4709a7b3e8d82",
"main.dart.js_7.part.js": "8be0e316eaf37cd214f3416fb6f77a61",
"main.dart.js_91.part.js": "92189d220fe4d4289e2caddb54f7c922",
"main.dart.js_8.part.js": "0986abe2bd269315abe0c99e9ed86dfa",
"main.dart.js_25.part.js": "f32790621868decce52ba74cbb332f57",
"main.dart.js_103.part.js": "f1e9b20944cc890407ce7cce685cd2a1",
"main.dart.js_1.part.js": "4acc5f72650834d5500393efa1f0158c",
"main.dart.js_3.part.js": "1eb6d309c7802eb425982fb0151204c9",
"main.dart.js_34.part.js": "679d8b869dd3e59125c3d73f4dec094a",
"main.dart.js_22.part.js": "a5aac19b08c88487adbf3159afb6659e",
"main.dart.js_14.part.js": "710f9c30df6fea46cc2ed16d592221a4",
"main.dart.js_49.part.js": "2bd35812a8dc59d2265932a9dcf4d635",
"main.dart.js_20.part.js": "17847bfd43ab558b5d083aecbef36ac8",
"main.dart.js_105.part.js": "5f9b78a1b1bd5dae980eb3c830cf0a3d",
"main.dart.js_6.part.js": "eb6a380a451a21354b4c34d63b2d083b",
"main.dart.js_87.part.js": "56bdfdea19f62d4b9436c5053df3f36e",
"main.dart.js_46.part.js": "f51d4d2473f4e84fb45cd83ccddb370d",
"main.dart.js_16.part.js": "d6afa1d0f89205a0326cfb679f569df1",
"main.dart.js_5.part.js": "626b929b557422a89ccfa3556bf991dc",
"main.dart.js_57.part.js": "029a2d475e138ec7509e233f0abd3838",
"main.dart.js_82.part.js": "3d87b14f3252b5eb6db5028f5cef6448",
"main.dart.js_17.part.js": "c294e6b81c6003eec8a2b99fc725ddcc",
"main.dart.js_36.part.js": "0ae383ca029afcdc0c2358cf56819367",
"main.dart.js_15.part.js": "53d9a34ac5e23930b8ece59f90f60900",
"main.dart.js_31.part.js": "df365a5242e68299339764ccb3770823",
"main.dart.js_21.part.js": "1cb2d2f8d371b0fca17d9b14e15a1edc",
"main.dart.js_10.part.js": "202b53c5de949b8c22e235c5e71d02f0",
"main.dart.js_73.part.js": "69e8d8a053d54ec8e6140b093a3771d7",
"main.dart.js_93.part.js": "5cb94bc8979effbbf2619d0256eb4c5d",
"main.dart.js_115.part.js": "bd46d8f45cb6d958dfed7d1d32674633",
"main.dart.js_54.part.js": "167b14af638e5c5cf00c5e6444303b89",
"main.dart.js_38.part.js": "f5e9d057a5c67f258fcf8f1214cf9205",
"main.dart.js_116.part.js": "02cba299246c6fe15c683c52eae4253f",
"main.dart.js_74.part.js": "8fdb39dc8cc9d97d7fe7a6e45189f487",
"main.dart.js_53.part.js": "b512ee22e6d04f23d2ab3a15d6dd4ea3",
"main.dart.js_96.part.js": "3f1aa7f7e77c29fca3ea2d5e1e0e737c",
"main.dart.js_81.part.js": "865aaec2e1f2a3164222fb79299fd713",
"main.dart.js_19.part.js": "24cbbac2ec92ab558ddff14299838737",
"main.dart.js_18.part.js": "a0ec3132bc8435fe2610a4bbf0a151d4",
"main.dart.js_84.part.js": "7d8cdb1e4fc0aa8e86abd57f4debb53c",
"main.dart.js_42.part.js": "be50778aa580bec596727eac0d672a6b",
"main.dart.js_55.part.js": "7e5ebfc4c327ad8aef71aa6203bef249",
"main.dart.js_107.part.js": "71be0519ca19acab870a3c1228f99372",
"main.dart.js_44.part.js": "3b292af19dc6ad22fce1095e00881f10",
"main.dart.js_65.part.js": "c1c4d22c6568310b590b781d2fe46934",
"main.dart.js_72.part.js": "ea55cf6e21ce0ee713264bac2ac16c8c",
"icons/Icon-maskable-512.png": "274a1e917760a1f046d666e6202d023a",
"icons/Icon-maskable-96.png": "91ebf99f57762a0a291d74ca8992d18c",
"icons/Icon-maskable-128.png": "246028210ed2ad790833d9bae1456df3",
"icons/Icon-192.png": "de2ec02df3a1869af4ad786b508d58d0",
"icons/Icon-maskable-192.png": "0bf4a53e4bdef76509c1639561988a14",
"icons/Icon-512.png": "80a96cdf564eb56bf72144a81d528408",
"main.dart.js_77.part.js": "8737ba5ba3420a1fc5292ebe73008b9b",
"main.dart.js_85.part.js": "bfb33a1d26d488c34fde8f718103f4b9",
"main.dart.js_108.part.js": "9e97014a9296f044e89162e38ba7a9b1",
"main.dart.js_59.part.js": "d99668103e1073d834ee91a41816936e",
"main.dart.js_94.part.js": "6b0c9583c1e0c6dfc26c1599bede70fc",
"main.dart.js_89.part.js": "73adb973c140e11774d1f1d25013fb70",
"main.dart.js_70.part.js": "13759af0c43bb9c4d2a06026885068fc",
"main.dart.js_33.part.js": "055779ac3391c8f96601720360c038a1",
"flutter.js": "83d881c1dbb6d6bcd6b42e274605b69c",
"main.dart.js_58.part.js": "6564737307133d5ec6d530da46694e0d",
"main.dart.js_24.part.js": "e0edbaafe5d4eba0b07efb93fa35238b",
"main.dart.js_48.part.js": "499fb1cddd3f4901150b398a62439097",
"main.dart.js_92.part.js": "e80bf5d11d41261af73f2bad4a494143",
"main.dart.js_110.part.js": "b9957b90ce71300d73957b05ab129907",
"main.dart.js_104.part.js": "373201dfd1d26f7b5fd894c3114158dc",
"main.dart.js_11.part.js": "f9a71d0c5dc08bb4d6bf337359a80eb9",
"index.html": "69aa3375e32d45576f2c3bf75da20a55",
"/": "69aa3375e32d45576f2c3bf75da20a55",
"main.dart.js_4.part.js": "8c935f94e961075d0c66d1df273711d1",
"main.dart.js_97.part.js": "8183019676ced6337f5f49caa14acb72",
"main.dart.js_26.part.js": "a43a4855f4f9ec8aeddb88c808ad9697",
"main.dart.js_47.part.js": "2252f5f60f199b985739f30633e74d34",
"main.dart.js_37.part.js": "e4f3e28c83cb939fa4394822862d9644",
"main.dart.js_27.part.js": "f348632e951dcea9fd6a57bcf64c717b",
"main.dart.js_99.part.js": "9f8024931fad5da7a312eacbc91c9b9e",
"main.dart.js_13.part.js": "bdf3505f367ad45574f40b15df27dfe0",
"main.dart.js_112.part.js": "c108338881f27fc9d87250bb5cc348d5",
"main.dart.js_43.part.js": "95273103a62c4021ae708c2f136f6b50",
"main.dart.js_39.part.js": "586545be203173c02d801d2b8b7546f7",
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
"main.dart.js_88.part.js": "8ad62c694010155cf135acea2e4014c8",
"main.dart.js_23.part.js": "c42617995b02c1a559fc20d7a2f13d09",
"main.dart.js_67.part.js": "504dc8dd3d3397ea30dcbf098ed9caaf",
"main.dart.js_111.part.js": "72d43f155577e1171f4c61ce729767a3",
"main.dart.js_114.part.js": "e4ebe44e14bb038f28eb8e08fea6c982",
"main.dart.js_69.part.js": "b061100430c9ed7861a4ed44a832e1f0",
"main.dart.js_100.part.js": "129b9600b80a1136d42a62394e10f2cb",
"manifest.json": "38212b39dd51df343b19bfa938e9ac4f",
"main.dart.js_78.part.js": "a48064c391abee55b329d2b1201ff66e",
"main.dart.js_90.part.js": "2ff9afbf3690cb42d66bd572a151355a",
"main.dart.js_35.part.js": "cb922bd92f8a8aeb9af3996b9dc9c2a3",
"main.dart.js_52.part.js": "3dd87907bf3b6492cfdf7db9a5e514d9",
"main.dart.js_95.part.js": "e6792afa16665120b43bf48baaeca4a7",
"version.json": "6b8b9140b83c40f85633ddfcd9f81cd7",
"main.dart.js_109.part.js": "2525151fa65f9b469de9c898e4d96d0a",
"main.dart.js_2.part.js": "5b5d60268e86462a85a5fff0e0d6bf3f",
"favicon.png": "306e7ba8f0872a8ae25be6aca7d80b7f",
"main.dart.js_45.part.js": "8d777de8cc1c79c386958a8d00f0f944",
"main.dart.js_56.part.js": "12e32b2d4c2f2cfa3d4d18c58f470dab",
"main.dart.js_80.part.js": "fc7d2be9f41d3ab71bb89c28aa2955b2",
"main.dart.js_86.part.js": "203b253da58c16b6b872b5743d60855d",
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
