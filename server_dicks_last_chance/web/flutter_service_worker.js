'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"main.dart.js": "b8fb5d1a7dcbf689ca62a12f8991901d",
"main.dart.js_98.part.js": "092c684fa869fd32abd2db4c66f02eb3",
"main.dart.js_66.part.js": "f0c053819a61782eed3b05f22bf54c55",
"main.dart.js_63.part.js": "69325cbbf221ae95240540dd2a036cfc",
"main.dart.js_32.part.js": "b0044b476b936f41ec49ac30224cb069",
"main.dart.js_75.part.js": "72bead08c880ed98131188753fd3943e",
"main.dart.js_9.part.js": "2c56ea8184f7a9db6153b3778ea93d4b",
"flutter_bootstrap.js": "491dc9ff6a3efd123a9d1a016333874b",
"main.dart.js_61.part.js": "d67a8406204d7742d64973c23427b719",
"main.dart.js_64.part.js": "b3cecb4ddefa38d5499b70d75ef9bd56",
"main.dart.js_60.part.js": "49e002650aa9c55cb4b0b7715b1584f5",
"main.dart.js_102.part.js": "d3a8bd009302d397b59136c8ecd0657b",
"main.dart.js_76.part.js": "fb51f3e902d4a45642fd5aca6d93a101",
"main.dart.js_106.part.js": "d2a2ccdb1969e8cc206b057a417f7cce",
"main.dart.js_62.part.js": "1c9f66d432e36d3b04a907366c03546b",
"main.dart.js_68.part.js": "6d75a872ca1038cb2ea1f180a5ebfe89",
"main.dart.js_83.part.js": "ec9b1807baec5f89d5664519629e2634",
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
"main.dart.js_71.part.js": "7b460ed2999635e28c616ca782e8c09f",
"main.dart.js_41.part.js": "3aeb99757c32e0f02d651b1ec8c74028",
"main.dart.js_50.part.js": "666dd7c9b0b906d35dd73cac6fac73f6",
"main.dart.js_40.part.js": "0455047b6ac4a52a8fe776fc2e16e7e7",
"main.dart.js_113.part.js": "5bf0940aacc2157208bf922998802b0c",
"main.dart.js_30.part.js": "35789a9d61ac07ec3be36d9586609de6",
"main.dart.js_51.part.js": "d8cbd14280f1d32982b78f7a07cf53f4",
"main.dart.js_28.part.js": "6a0f67a30aabcde6730aa2d991057f22",
"main.dart.js_29.part.js": "ba0f607780b09ebeb8f869f0fc45da8f",
"main.dart.js_7.part.js": "29ea57c8b6a5f7e2a2e290d30d75d03b",
"main.dart.js_91.part.js": "f4cb0adbbc6e7b215e2ff8b388d83d70",
"main.dart.js_8.part.js": "cfe17923873df2cefd75bb697a38cc1d",
"main.dart.js_25.part.js": "5931f25aba6cb9d28086e4f28c89b2d6",
"main.dart.js_103.part.js": "f1e9b20944cc890407ce7cce685cd2a1",
"main.dart.js_1.part.js": "0295c882cddaa1061c9df96596bb75fa",
"main.dart.js_3.part.js": "d725f01c8d7ad1feef2bd83c6292377d",
"main.dart.js_34.part.js": "b1569a52e9a3724b61dd57a6ff20a6a8",
"main.dart.js_22.part.js": "24df11f48b147198ced0611ea69b13a1",
"main.dart.js_14.part.js": "ec0b75e83310401e2f26fadf9aff681a",
"main.dart.js_49.part.js": "ffe1dc7c6aa35ff7c7c153858ea1f8d4",
"main.dart.js_20.part.js": "5da749f633fdfc17c831de16a8fbcda6",
"main.dart.js_105.part.js": "5f9b78a1b1bd5dae980eb3c830cf0a3d",
"main.dart.js_6.part.js": "f423c710e4246d93695e532e3367ad2e",
"main.dart.js_87.part.js": "41e6992a8c4a810ee398faf31b8e135d",
"main.dart.js_46.part.js": "280a4731ab8151b879b13b522a25bd05",
"main.dart.js_16.part.js": "5c029691882da12005c869120df754a9",
"main.dart.js_5.part.js": "21240a9c889ecd5565166765f86c831c",
"main.dart.js_57.part.js": "a414171bee83dd13523b7557f2b720eb",
"main.dart.js_82.part.js": "3b481e846ea5728a42083d341e66c22a",
"main.dart.js_17.part.js": "3d0fe44a91938dea41f9a94af97f572a",
"main.dart.js_36.part.js": "0774385a740d3b517be8f7756fda1804",
"main.dart.js_15.part.js": "ebb17b7a76ac9102609c748cc39033fe",
"main.dart.js_31.part.js": "9f070d2dff11339cfd8f01f9b5dd6f5f",
"main.dart.js_21.part.js": "af1802c0e432e7bb05ef76fb1e017546",
"main.dart.js_10.part.js": "1030c0ee3aa0103930df8182759672d6",
"main.dart.js_73.part.js": "c9cc18ad9b247e0ec55c47f7e39479d1",
"main.dart.js_93.part.js": "a02e1d1330e7258aa169bed0eca8bc8b",
"main.dart.js_115.part.js": "bd46d8f45cb6d958dfed7d1d32674633",
"main.dart.js_54.part.js": "0a3a06393bd4a6c781e9838ec7a0160b",
"main.dart.js_38.part.js": "ac01d52e8d6e641e7a8b9f7e8a76fe51",
"main.dart.js_116.part.js": "02cba299246c6fe15c683c52eae4253f",
"main.dart.js_74.part.js": "6e45174bad443fe617ce950b35c3e078",
"main.dart.js_53.part.js": "ccb580906231dc16f8e893183771916d",
"main.dart.js_96.part.js": "1c0f65bfc996bff016587c4ac1d44fa9",
"main.dart.js_81.part.js": "1db9b44e2ffe3335221891460f6b2eff",
"main.dart.js_19.part.js": "97a4fd165c57b997f49576ccd4d53f7a",
"main.dart.js_18.part.js": "6c32bbd37719083af97f7c4303b608b5",
"main.dart.js_84.part.js": "76a2a0a63c59c3de8b7286979e13deb3",
"main.dart.js_42.part.js": "db3228a0f076900cf38418ab9481c898",
"main.dart.js_55.part.js": "542383bcff6925c8a88691f3335192e9",
"main.dart.js_107.part.js": "71be0519ca19acab870a3c1228f99372",
"main.dart.js_44.part.js": "f2a37f4e02e6a73ae400b38af457b47d",
"main.dart.js_65.part.js": "44d3f78181698717205a928e325ea059",
"main.dart.js_72.part.js": "3f1dcd909b4c4a29a494cd8b4563f52a",
"icons/Icon-maskable-512.png": "274a1e917760a1f046d666e6202d023a",
"icons/Icon-maskable-96.png": "91ebf99f57762a0a291d74ca8992d18c",
"icons/Icon-maskable-128.png": "246028210ed2ad790833d9bae1456df3",
"icons/Icon-192.png": "de2ec02df3a1869af4ad786b508d58d0",
"icons/Icon-maskable-192.png": "0bf4a53e4bdef76509c1639561988a14",
"icons/Icon-512.png": "80a96cdf564eb56bf72144a81d528408",
"main.dart.js_77.part.js": "58eb8b3a0dc2ba43d6df8a7b852816b0",
"main.dart.js_85.part.js": "b39fd9aed1cb04ce8b31068a3c511bb3",
"main.dart.js_108.part.js": "9e97014a9296f044e89162e38ba7a9b1",
"main.dart.js_59.part.js": "c959dabf22c61b3a82307df504ef3446",
"main.dart.js_94.part.js": "799f97ed1f5914e7354fddbdcc6e6a84",
"main.dart.js_89.part.js": "594cd8f57a5756772e7709f01e27b291",
"main.dart.js_70.part.js": "d5772394fcf53b06557596b073f57dc3",
"main.dart.js_33.part.js": "c89ec41c7d037730bc96ea4d8884e029",
"flutter.js": "83d881c1dbb6d6bcd6b42e274605b69c",
"main.dart.js_58.part.js": "a45844068c09d2b8884fe01e0a6d0c11",
"main.dart.js_24.part.js": "f8de48bb692dbfc4fdafe85014f92238",
"main.dart.js_48.part.js": "6eefa74d28615bdd7c65d35e29392f40",
"main.dart.js_92.part.js": "b660f0f01be9bea55b17682f62e81f09",
"main.dart.js_110.part.js": "b9957b90ce71300d73957b05ab129907",
"main.dart.js_104.part.js": "373201dfd1d26f7b5fd894c3114158dc",
"main.dart.js_11.part.js": "371f829edce8a42199eca10d841e63ed",
"index.html": "2c5bb45b65a51a887d2f33b17bbfac0a",
"/": "2c5bb45b65a51a887d2f33b17bbfac0a",
"main.dart.js_4.part.js": "7a7d89fcb848d83058bb22029f0f4ae3",
"main.dart.js_97.part.js": "8183019676ced6337f5f49caa14acb72",
"main.dart.js_26.part.js": "72b6d8dd838b25829559ac37a68a1bd5",
"main.dart.js_47.part.js": "87805e2546702277ef317f7751678fac",
"main.dart.js_37.part.js": "11d13d5cd6c83373e970aaac5a2317cc",
"main.dart.js_27.part.js": "3bab5f80ad9a230f910e9b7f6407ca41",
"main.dart.js_99.part.js": "9f8024931fad5da7a312eacbc91c9b9e",
"main.dart.js_13.part.js": "6367fa96fada418df37dd2d692a8cf62",
"main.dart.js_112.part.js": "c108338881f27fc9d87250bb5cc348d5",
"main.dart.js_43.part.js": "69d3fb0e0214535bf4a0a059076f4e48",
"main.dart.js_39.part.js": "995d59025616294e90375a5ca5937e59",
"assets/AssetManifest.bin": "cd5d7abf98054bdf8a9d1c8eb941fcd0",
"assets/cargoship/iconttf/RpgAwesome.ttf": "3fb8d0aa42860e8db819f5d3c65834c5",
"assets/cargoship/builtin_fonts/Palatino_bold.ttf": "975972a205fd91a532d1b7433281af70",
"assets/cargoship/builtin_fonts/Palatino_italic.ttf": "be4590eba976dace111b6686f6dade52",
"assets/cargoship/builtin_fonts/Rubik-VariableFont_wght.ttf": "6d3102fa33194bef395536d580f91b56",
"assets/cargoship/builtin_fonts/Palatino_roman.ttf": "96261bb90c9babbf8042ce7f43200d65",
"assets/cargoship/builtin_fonts/Palatino_bolditalic.ttf": "beef66370e7124eb683514ad9ad07576",
"assets/AssetManifest.bin.json": "50204dc89005b799bf8b48ba16a1d3d7",
"assets/fonts/MaterialIcons-Regular.otf": "29317953b0c1eeb28fd658e276c0b72b",
"assets/FontManifest.json": "3002a5264f22544b5ff394355b0605d5",
"assets/AssetManifest.json": "845139c6a2d4e9245bbe46e978b2be42",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/NOTICES": "9c1692f49e2646eac51f22def6eece56",
"main.dart.js_88.part.js": "7d1e84b46bc86318ff79c4bc1d6b7970",
"main.dart.js_23.part.js": "8fac0e7d9df2479eb100baf94b6415fc",
"main.dart.js_67.part.js": "ed331f766033735cb02221fd1779721b",
"main.dart.js_111.part.js": "72d43f155577e1171f4c61ce729767a3",
"main.dart.js_114.part.js": "e4ebe44e14bb038f28eb8e08fea6c982",
"main.dart.js_69.part.js": "d2f70ba97ad72632f3399cb8b4429a7b",
"main.dart.js_100.part.js": "129b9600b80a1136d42a62394e10f2cb",
"manifest.json": "f41a1bcf7dd669f69c5758ad491dac0c",
"main.dart.js_78.part.js": "56158b8551b2147c37f529fecf788dd9",
"main.dart.js_90.part.js": "c0c20a6bbe84e06dcdaae665be93f8b3",
"main.dart.js_35.part.js": "107b46b76b391b1da7ddfb73819512d3",
"main.dart.js_52.part.js": "8eb028ff7e5a38fe1844057d734cc4d3",
"main.dart.js_95.part.js": "63bde77155c513da28ff09c1fb8a6c67",
"version.json": "6b8b9140b83c40f85633ddfcd9f81cd7",
"main.dart.js_109.part.js": "2525151fa65f9b469de9c898e4d96d0a",
"main.dart.js_2.part.js": "6f29a102bfb9a70fff523c394db36165",
"favicon.png": "306e7ba8f0872a8ae25be6aca7d80b7f",
"main.dart.js_45.part.js": "e6bdf98da628a1a6c6a4c1a89336a9e5",
"main.dart.js_56.part.js": "959f6d778d1cff47f7b7a5a42994a5e8",
"main.dart.js_80.part.js": "b944844f503f6bfc576bfc76ce1d14c0",
"main.dart.js_86.part.js": "3df17f5e7824cd81bf59fe80e997c723",
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
