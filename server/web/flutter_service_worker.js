'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"main.dart.js": "b028fe98421c39c89f01d09037f1ad3b",
"main.dart.js_98.part.js": "092c684fa869fd32abd2db4c66f02eb3",
"main.dart.js_66.part.js": "0b914d9ced9d89031d4a7dfd2b736040",
"main.dart.js_63.part.js": "3912e093f4220b35f94a14163d7fbf14",
"main.dart.js_32.part.js": "00409528e4500abf9ebc06faa50c315a",
"main.dart.js_75.part.js": "530b1faac1e40e0d7672ed3e66b5b068",
"main.dart.js_9.part.js": "21cf22c2ea347dce5154f2b8d17dfd95",
"flutter_bootstrap.js": "cce78d87a91eb4c3a7b097f7fd482fb9",
"main.dart.js_61.part.js": "a0b6b0288145937497dccf22f8c0311b",
"main.dart.js_64.part.js": "6f244020cff303b1772fda7d1655a683",
"main.dart.js_60.part.js": "9223f3802612b142c9069a374493e8d2",
"main.dart.js_102.part.js": "d3a8bd009302d397b59136c8ecd0657b",
"main.dart.js_76.part.js": "9a7ddfcc5c17ece53c0f0c22cb13b4d4",
"main.dart.js_106.part.js": "d2a2ccdb1969e8cc206b057a417f7cce",
"main.dart.js_62.part.js": "aee756d62f6b73f91901329579f959fe",
"main.dart.js_68.part.js": "86b64e996d73d64a28790ed0591c9ee2",
"main.dart.js_83.part.js": "157bb765608794ed48bd31230b7ca926",
"canvaskit/canvaskit.js.symbols": "bdcd3835edf8586b6d6edfce8749fb77",
"canvaskit/canvaskit.wasm": "7a3f4ae7d65fc1de6a6e7ddd3224bc93",
"canvaskit/chromium/canvaskit.js.symbols": "b61b5f4673c9698029fa0a746a9ad581",
"canvaskit/chromium/canvaskit.wasm": "f504de372e31c8031018a9ec0a9ef5f0",
"canvaskit/chromium/canvaskit.js": "8191e843020c832c9cf8852a4b909d4c",
"canvaskit/skwasm.wasm": "39dd80367a4e71582d234948adc521c0",
"canvaskit/skwasm.js.symbols": "e72c79950c8a8483d826a7f0560573a1",
"canvaskit/canvaskit.js": "728b2d477d9b8c14593d4f9b82b484f3",
"canvaskit/skwasm.js": "ea559890a088fe28b4ddf70e17e60052",
"main.dart.js_79.part.js": "794a90a690a68b37682b18ee6934ce14",
"main.dart.js_71.part.js": "1cd028db73321cf7c6451d624bafb571",
"main.dart.js_41.part.js": "426b5c624c81d68ae65e173adbe49f48",
"main.dart.js_50.part.js": "4053097aa0999be00608bdecaddd5226",
"main.dart.js_40.part.js": "334ae5f39a184b4bac81ce8ed284b10e",
"main.dart.js_113.part.js": "5bf0940aacc2157208bf922998802b0c",
"main.dart.js_30.part.js": "02c055a80e892e6e9b8d283e7996517a",
"main.dart.js_51.part.js": "a3b3eb8068a5fcf4a0a2fd55df0b02d2",
"main.dart.js_28.part.js": "91c9fb21da0346dab019b80a6e32f944",
"main.dart.js_29.part.js": "c2ba756a39e1a4ab1071c0d7d41c74a2",
"main.dart.js_7.part.js": "3047a844dd8f46f6b083b4531d248219",
"main.dart.js_91.part.js": "2877cb3cf052ba54699ffc5c1f8bf7d1",
"main.dart.js_8.part.js": "b71fd62dc21601bb5cea32dc5ee13742",
"main.dart.js_25.part.js": "9acd2e9c896e8256d9fec4bffbae61c9",
"main.dart.js_103.part.js": "f1e9b20944cc890407ce7cce685cd2a1",
"main.dart.js_1.part.js": "3b9b22308ba77ac3252501e4e66ba4f9",
"main.dart.js_3.part.js": "41fdb3fdf03dca1dbaf0dc836b083b52",
"main.dart.js_34.part.js": "3eaacfe3ccee882e65021e09957bcf9a",
"main.dart.js_22.part.js": "62d42243d2b40281f1e91029b8938d23",
"main.dart.js_14.part.js": "f3f58ff29f6d0d02cb63fa793b256f2b",
"main.dart.js_49.part.js": "fc2b2c85a4bbbfd2852345c09a4b4531",
"main.dart.js_20.part.js": "2706fe4710affefee6dda81b013da4fc",
"main.dart.js_105.part.js": "5f9b78a1b1bd5dae980eb3c830cf0a3d",
"main.dart.js_6.part.js": "eb6a380a451a21354b4c34d63b2d083b",
"main.dart.js_87.part.js": "139f87f30e1ec6b53ecadc21c7680251",
"main.dart.js_46.part.js": "61a59ae2e15d2740d2cc786ccfe8a541",
"main.dart.js_16.part.js": "b798ee17eea44b16c1f8025f08303f8f",
"main.dart.js_5.part.js": "3784538f2af63519bb34a49b4f79a504",
"main.dart.js_57.part.js": "6845dde410afec8ab5095649fafefe81",
"main.dart.js_82.part.js": "3d87b14f3252b5eb6db5028f5cef6448",
"main.dart.js_17.part.js": "6bd8f9f122dfde6502e039772f9cbea8",
"main.dart.js_36.part.js": "0ae383ca029afcdc0c2358cf56819367",
"main.dart.js_15.part.js": "d5dcbe26586257baf01a90ac159d6aac",
"main.dart.js_31.part.js": "919539973e1122783b62872572731c22",
"main.dart.js_21.part.js": "01addd88aa45389d383255997e4688d4",
"main.dart.js_10.part.js": "202b53c5de949b8c22e235c5e71d02f0",
"main.dart.js_73.part.js": "764c6aa0f84215325a6d267ca3cfc5e4",
"main.dart.js_93.part.js": "9b127dbb5b7a197e5b6a7d1b007ca8fa",
"main.dart.js_115.part.js": "bd46d8f45cb6d958dfed7d1d32674633",
"main.dart.js_54.part.js": "167b14af638e5c5cf00c5e6444303b89",
"main.dart.js_38.part.js": "f5e9d057a5c67f258fcf8f1214cf9205",
"main.dart.js_116.part.js": "02cba299246c6fe15c683c52eae4253f",
"main.dart.js_74.part.js": "1cbca9d95de90eff0f3b70aa3ce6afe4",
"main.dart.js_53.part.js": "47531a18d27e4c450e05960a530fd33c",
"main.dart.js_96.part.js": "3f1aa7f7e77c29fca3ea2d5e1e0e737c",
"main.dart.js_81.part.js": "526301bf151e43ded33f2270bba32c30",
"main.dart.js_19.part.js": "d281a45ff71167d82b5fc43deb31a9d3",
"main.dart.js_18.part.js": "e777ac2e351a0aa609b217c4488f25a9",
"main.dart.js_84.part.js": "2fe901a398146c0d2ba02ff3d262cafa",
"main.dart.js_42.part.js": "262a812eb4d781d7c6657f10bac66acc",
"main.dart.js_55.part.js": "fa19d8b757f9197469bdddd990417a58",
"main.dart.js_107.part.js": "71be0519ca19acab870a3c1228f99372",
"main.dart.js_44.part.js": "d289992f54c6922b8ea40538eaa9ff78",
"main.dart.js_65.part.js": "5c9dbf1e2f1ce1cdf08e4e1e053a2910",
"main.dart.js_72.part.js": "9f1f4eb2f350d408a0a5d87394645159",
"icons/Icon-maskable-512.png": "274a1e917760a1f046d666e6202d023a",
"icons/Icon-maskable-96.png": "91ebf99f57762a0a291d74ca8992d18c",
"icons/Icon-maskable-128.png": "246028210ed2ad790833d9bae1456df3",
"icons/Icon-192.png": "de2ec02df3a1869af4ad786b508d58d0",
"icons/Icon-maskable-192.png": "0bf4a53e4bdef76509c1639561988a14",
"icons/Icon-512.png": "80a96cdf564eb56bf72144a81d528408",
"main.dart.js_77.part.js": "a2f6f75a702cf6cabb93af18f26c15d2",
"main.dart.js_85.part.js": "77da141d1ab996471189a7c4e0cbfb28",
"main.dart.js_108.part.js": "9e97014a9296f044e89162e38ba7a9b1",
"main.dart.js_59.part.js": "d99668103e1073d834ee91a41816936e",
"main.dart.js_94.part.js": "6b0c9583c1e0c6dfc26c1599bede70fc",
"main.dart.js_89.part.js": "73adb973c140e11774d1f1d25013fb70",
"main.dart.js_70.part.js": "0e3b7534d76111f79ce078372ca2dad1",
"main.dart.js_33.part.js": "b39efbd2163540b860fae0e8836398fc",
"flutter.js": "83d881c1dbb6d6bcd6b42e274605b69c",
"main.dart.js_58.part.js": "6564737307133d5ec6d530da46694e0d",
"main.dart.js_24.part.js": "4bd0d3f542e55780200a15aedff78b13",
"main.dart.js_48.part.js": "b2f9233694aaa92dfac65a1223199581",
"main.dart.js_92.part.js": "c568026dee68925df76cfb1a17539bcf",
"main.dart.js_110.part.js": "b9957b90ce71300d73957b05ab129907",
"main.dart.js_104.part.js": "373201dfd1d26f7b5fd894c3114158dc",
"main.dart.js_11.part.js": "8a4dc02241be013d7c7a0eb158cd2ef0",
"index.html": "69aa3375e32d45576f2c3bf75da20a55",
"/": "69aa3375e32d45576f2c3bf75da20a55",
"main.dart.js_4.part.js": "8c935f94e961075d0c66d1df273711d1",
"main.dart.js_97.part.js": "8183019676ced6337f5f49caa14acb72",
"main.dart.js_26.part.js": "ac17bf16140c27597df76159f5ad0291",
"main.dart.js_47.part.js": "32ca4e78a296fb35c6b81884cb9f3571",
"main.dart.js_37.part.js": "0616372203120dff36d87538ec1af5fa",
"main.dart.js_27.part.js": "c0906a21018c66b045f674bd31012d28",
"main.dart.js_99.part.js": "9f8024931fad5da7a312eacbc91c9b9e",
"main.dart.js_13.part.js": "6578ec7735c01c08b71fca421135bf95",
"main.dart.js_112.part.js": "c108338881f27fc9d87250bb5cc348d5",
"main.dart.js_43.part.js": "f849633cde5e6558bea92d272e6b8b1f",
"main.dart.js_39.part.js": "deb998d87c096216e10b311fb3f5379e",
"assets/AssetManifest.bin": "dc416fefc61bf6fa584419654e74b503",
"assets/cargoship/iconttf/RpgAwesome.ttf": "3fb8d0aa42860e8db819f5d3c65834c5",
"assets/cargoship/builtin_fonts/Palatino_bold.ttf": "975972a205fd91a532d1b7433281af70",
"assets/cargoship/builtin_fonts/Palatino_italic.ttf": "be4590eba976dace111b6686f6dade52",
"assets/cargoship/builtin_fonts/Rubik-VariableFont_wght.ttf": "6d3102fa33194bef395536d580f91b56",
"assets/cargoship/builtin_fonts/Palatino_roman.ttf": "96261bb90c9babbf8042ce7f43200d65",
"assets/cargoship/builtin_fonts/Palatino_bolditalic.ttf": "beef66370e7124eb683514ad9ad07576",
"assets/AssetManifest.bin.json": "a8d1fbe0cfd6cef18ceaf86bef6143b3",
"assets/fonts/MaterialIcons-Regular.otf": "6d159077de259d94cfba0155cfb7505c",
"assets/FontManifest.json": "3002a5264f22544b5ff394355b0605d5",
"assets/AssetManifest.json": "15a1a820c6e9f5b070884b5d1b8d986e",
"assets/shaders/earth_shader.frag": "caf56930d35615fe17651639db897543",
"assets/shaders/simple.frag": "0c2299d2b35041e8ce02cbf2404d1a27",
"assets/shaders/continents.frag": "065e06a6d824796a063cecd71a94cc56",
"assets/shaders/clouds.frag": "3bd92841974db1d2e588a0e56e0b8dc1",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/NOTICES": "9c1692f49e2646eac51f22def6eece56",
"main.dart.js_88.part.js": "e32c8c54b379b9fff15d6550c39cdcd3",
"main.dart.js_23.part.js": "71525f494e74403e0fbb2458a7166eba",
"main.dart.js_67.part.js": "68e4871e0a408819320062c2b5e4d457",
"main.dart.js_111.part.js": "72d43f155577e1171f4c61ce729767a3",
"main.dart.js_114.part.js": "e4ebe44e14bb038f28eb8e08fea6c982",
"main.dart.js_69.part.js": "77600d519d8e7e8f02a23a33539a45d5",
"main.dart.js_100.part.js": "129b9600b80a1136d42a62394e10f2cb",
"manifest.json": "38212b39dd51df343b19bfa938e9ac4f",
"main.dart.js_78.part.js": "a649f32b94745f9d33baee93f0b69f16",
"main.dart.js_90.part.js": "d4637d8feff1f4b75002339c260a782a",
"main.dart.js_35.part.js": "17cc546dcf6d993885dc2d288f6291e4",
"main.dart.js_52.part.js": "b0a044c5d0a66c1eb30740479e179ae0",
"main.dart.js_95.part.js": "e6792afa16665120b43bf48baaeca4a7",
"version.json": "6b8b9140b83c40f85633ddfcd9f81cd7",
"main.dart.js_109.part.js": "2525151fa65f9b469de9c898e4d96d0a",
"main.dart.js_2.part.js": "4a13b9f506ee2c52b9861960bd380181",
"favicon.png": "306e7ba8f0872a8ae25be6aca7d80b7f",
"main.dart.js_45.part.js": "aac427e918c2882a9f38e80e471473ec",
"main.dart.js_56.part.js": "c0ddf05398f3310354f3a49f07ed5426",
"main.dart.js_80.part.js": "1e599034977b1aa3f0cf23ca9fbe1b84",
"main.dart.js_86.part.js": "0276aec7d22f827ae921302a85623acf",
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
