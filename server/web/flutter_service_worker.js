'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"main.dart.js": "c68055421a8c574c62d038c43603b22b",
"main.dart.js_98.part.js": "092c684fa869fd32abd2db4c66f02eb3",
"main.dart.js_66.part.js": "0a2aeb2179bcb2208dd977e6710eee79",
"main.dart.js_63.part.js": "cd8c6c42fd42990b7b38b74e4a634762",
"main.dart.js_75.part.js": "ff7d0e0906e68b929732bdb5a639b56c",
"flutter_bootstrap.js": "c0dace5183e0baab3506e94712fa5b41",
"main.dart.js_61.part.js": "d83f1a5f02c3e9638ce180566e133945",
"main.dart.js_64.part.js": "282d9b11cd342ede0f78c33354bc90e1",
"main.dart.js_102.part.js": "d3a8bd009302d397b59136c8ecd0657b",
"main.dart.js_76.part.js": "18ae4a16d1eb10acdd805310e2944822",
"main.dart.js_106.part.js": "d2a2ccdb1969e8cc206b057a417f7cce",
"main.dart.js_62.part.js": "d6eeade8ec5ce971e58d9bf0342d9d07",
"main.dart.js_68.part.js": "99d5c63dae827f97f7a9aa13f5efeba5",
"canvaskit/canvaskit.js.symbols": "bdcd3835edf8586b6d6edfce8749fb77",
"canvaskit/canvaskit.wasm": "7a3f4ae7d65fc1de6a6e7ddd3224bc93",
"canvaskit/chromium/canvaskit.js.symbols": "b61b5f4673c9698029fa0a746a9ad581",
"canvaskit/chromium/canvaskit.wasm": "f504de372e31c8031018a9ec0a9ef5f0",
"canvaskit/chromium/canvaskit.js": "8191e843020c832c9cf8852a4b909d4c",
"canvaskit/skwasm.wasm": "39dd80367a4e71582d234948adc521c0",
"canvaskit/skwasm.js.symbols": "e72c79950c8a8483d826a7f0560573a1",
"canvaskit/canvaskit.js": "728b2d477d9b8c14593d4f9b82b484f3",
"canvaskit/skwasm.js": "ea559890a088fe28b4ddf70e17e60052",
"main.dart.js_79.part.js": "31cf19565b2b77bc17f06fcc39fe7274",
"main.dart.js_71.part.js": "1d190bae102d88999aa6a3491e07f9c0",
"main.dart.js_50.part.js": "c8fd66fb93c281274208786600ad53dc",
"main.dart.js_40.part.js": "1e4ec0dfbac673a4481d526c78f9f11d",
"main.dart.js_113.part.js": "5bf0940aacc2157208bf922998802b0c",
"main.dart.js_30.part.js": "63503a7506a7d061170b184dc95d7589",
"main.dart.js_51.part.js": "953fb156e4e3c32e656110e616d8693b",
"main.dart.js_7.part.js": "2ff955f73d29e3348c80788053dd7264",
"main.dart.js_91.part.js": "2aede78f609f8d4457c7c4c6d4eb7915",
"main.dart.js_8.part.js": "c80abb3c08357b11ff1429dafb056156",
"main.dart.js_103.part.js": "f1e9b20944cc890407ce7cce685cd2a1",
"main.dart.js_1.part.js": "0b1859ded6d11104289a33e3b75b9b73",
"main.dart.js_3.part.js": "200cd47ca1ea8ad79beccf7b06ee078f",
"main.dart.js_14.part.js": "d2c14d59f80bd35720117e0e5e004d13",
"main.dart.js_49.part.js": "712d0663441282a0686adc4d364cdfe7",
"main.dart.js_20.part.js": "854d0daa7f313c1c7249a94eb0c64d1c",
"main.dart.js_105.part.js": "5f9b78a1b1bd5dae980eb3c830cf0a3d",
"main.dart.js_6.part.js": "5de797c3b1a311f007fd99a7e665e3cf",
"main.dart.js_87.part.js": "a4d8bf54edb6708349bbadb6f08ecdf2",
"main.dart.js_16.part.js": "63c1e7adac95e6579db4c4ed467459ef",
"main.dart.js_5.part.js": "5e3ca63234fad1a1de83c0e3d7448a68",
"main.dart.js_17.part.js": "936594ad22da63069c60fe537f303041",
"main.dart.js_36.part.js": "a5a8f9067a90b75f8a9b986b933027dd",
"main.dart.js_15.part.js": "484e6c0ce85a00d19f3e7349ea06a17c",
"main.dart.js_31.part.js": "e93b44fe2b841375e63103c82694d6d1",
"main.dart.js_21.part.js": "36c2d24d10214305430d35917680428a",
"main.dart.js_73.part.js": "e0e92fd003af1bf6fbf7a65adf9581ff",
"main.dart.js_115.part.js": "bd46d8f45cb6d958dfed7d1d32674633",
"main.dart.js_54.part.js": "14a70d7c3e6a78b45c52ce92ebce9b06",
"main.dart.js_116.part.js": "02cba299246c6fe15c683c52eae4253f",
"main.dart.js_74.part.js": "332390170af0b65b273751e7e5ddb50b",
"main.dart.js_53.part.js": "ad90024834d83408630d2a7b397811ec",
"main.dart.js_96.part.js": "1c0f65bfc996bff016587c4ac1d44fa9",
"main.dart.js_81.part.js": "97fd9aa4de2a37067065c9ec4867e794",
"main.dart.js_19.part.js": "81b17ab2b676627bb597b2d45680f7d9",
"main.dart.js_18.part.js": "cc1ca76b91e3646c8d2a430b42340cfc",
"main.dart.js_42.part.js": "4d2b8cff3c2b1ab63d34c0aa2434279e",
"main.dart.js_55.part.js": "1275d466f1f5ba75908c953df65b294a",
"main.dart.js_107.part.js": "71be0519ca19acab870a3c1228f99372",
"main.dart.js_44.part.js": "521ed5cae1bc36d97eed751ac419345c",
"main.dart.js_65.part.js": "27f5ef2b72a07b66d7fcb013ad106a95",
"main.dart.js_72.part.js": "0860db160202aaf6c06d146339fd4b65",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"main.dart.js_77.part.js": "33d15695677f4489146ec15b90e6be94",
"main.dart.js_85.part.js": "312cead57919542799ec24e0e070306d",
"main.dart.js_108.part.js": "9e97014a9296f044e89162e38ba7a9b1",
"main.dart.js_59.part.js": "7af367b9cbe93f4d105909e376e7509b",
"main.dart.js_94.part.js": "eff5ee87888953b937afcbfb77bf56cb",
"main.dart.js_89.part.js": "17e461bdef07c27552fa3d77111f2f4a",
"main.dart.js_70.part.js": "671fc4fd16204ad4ba41e20e53df8b8e",
"flutter.js": "83d881c1dbb6d6bcd6b42e274605b69c",
"main.dart.js_58.part.js": "8b0677931a0232c0985939529fd4f140",
"main.dart.js_24.part.js": "6fe61612b80ec2fe697d01d3f835e651",
"main.dart.js_48.part.js": "35eb48efc71db03b066abfda086bd651",
"main.dart.js_92.part.js": "c6f5d82299fd3f68bb1fdd3f2da20acf",
"main.dart.js_110.part.js": "b9957b90ce71300d73957b05ab129907",
"main.dart.js_104.part.js": "373201dfd1d26f7b5fd894c3114158dc",
"main.dart.js_11.part.js": "3403aa0d69879cd040aad3c323cac532",
"index.html": "2c5bb45b65a51a887d2f33b17bbfac0a",
"/": "2c5bb45b65a51a887d2f33b17bbfac0a",
"main.dart.js_4.part.js": "df5007154582cd1c1ea84aa646ca97a3",
"main.dart.js_97.part.js": "8183019676ced6337f5f49caa14acb72",
"main.dart.js_47.part.js": "e482015784ad94ecad7e0b04bdb2248d",
"main.dart.js_37.part.js": "45addaa837597a148d89ad79109457f9",
"main.dart.js_27.part.js": "2cd067746b8de5974c81d82a754cde5f",
"main.dart.js_99.part.js": "9f8024931fad5da7a312eacbc91c9b9e",
"main.dart.js_13.part.js": "f5bb5aa56e0dbc5eb5f0d868b7a37667",
"main.dart.js_112.part.js": "c108338881f27fc9d87250bb5cc348d5",
"main.dart.js_43.part.js": "db61fde8aa7eb217f7da40dc20f3f399",
"main.dart.js_39.part.js": "24e57b2511a9414a739362055992ea16",
"assets/AssetManifest.bin": "426f7e00719df83b1fb71218889d2b29",
"assets/cargoship/iconttf/RpgAwesome.ttf": "3fb8d0aa42860e8db819f5d3c65834c5",
"assets/cargoship/builtin_fonts/Palatino_bold.ttf": "975972a205fd91a532d1b7433281af70",
"assets/cargoship/builtin_fonts/Palatino_italic.ttf": "be4590eba976dace111b6686f6dade52",
"assets/cargoship/builtin_fonts/Rubik-VariableFont_wght.ttf": "6d3102fa33194bef395536d580f91b56",
"assets/cargoship/builtin_fonts/Palatino_roman.ttf": "96261bb90c9babbf8042ce7f43200d65",
"assets/cargoship/builtin_fonts/Palatino_bolditalic.ttf": "beef66370e7124eb683514ad9ad07576",
"assets/AssetManifest.bin.json": "9f59ea2e26a7dae666d1140e30f36724",
"assets/fonts/MaterialIcons-Regular.otf": "cd3f2c6f28d35ed7ff7b76e805582b0e",
"assets/FontManifest.json": "3002a5264f22544b5ff394355b0605d5",
"assets/AssetManifest.json": "d1b63beb4cb8352eaf8077430f8d58b7",
"assets/packages/hyphenator_impure/hyphenate_patterns/hyph-hu.tex": "92da72f62c22676dd856f45c7f30ba82",
"assets/packages/hyphenator_impure/hyphenate_patterns/hyph-de-1996.tex": "c0efcc10c68f3c2ff922a3dd5a9b4358",
"assets/packages/hyphenator_impure/hyphenate_patterns/hyph-nl.tex": "46ac935aeabbbe857eadbfb5f9445591",
"assets/packages/hyphenator_impure/hyphenate_patterns/hyph-nb.tex": "585baf64d316bded05e0f685790be077",
"assets/packages/hyphenator_impure/hyphenate_patterns/hyph-cs.tex": "cda88f6a55299f107eefcae42bb37b96",
"assets/packages/hyphenator_impure/hyphenate_patterns/hyph-it.tex": "2972a9b9706722ecaeb754d86cba46cf",
"assets/packages/hyphenator_impure/hyphenate_patterns/hyph-fi.tex": "4f57e618128f460c6d398bfee48ff6d4",
"assets/packages/hyphenator_impure/hyphenate_patterns/hyph-pt-pt.tex": "c578d81d3ce83cbb7f4836c28d46e60e",
"assets/packages/hyphenator_impure/hyphenate_patterns/hyph-pt-br.tex": "c578d81d3ce83cbb7f4836c28d46e60e",
"assets/packages/hyphenator_impure/hyphenate_patterns/hyph-ru.tex": "93c222e9f8cdc5e29e5cb7d3fef9f00c",
"assets/packages/hyphenator_impure/hyphenate_patterns/hyph-es-419.tex": "9f711bf0669ae0dd7b625e46e7fc6666",
"assets/packages/hyphenator_impure/hyphenate_patterns/hyph-en-us.tex": "a8e06b7542c94f360a1e3f9bec0cd07b",
"assets/packages/hyphenator_impure/hyphenate_patterns/hyph-bg.tex": "62a46cbcf6eb76811b11b09f12d16cd5",
"assets/packages/hyphenator_impure/hyphenate_patterns/hyph-tr.tex": "da38eba98b2f563d30e80602f3f1b175",
"assets/packages/hyphenator_impure/hyphenate_patterns/hyph-es-es.tex": "9f711bf0669ae0dd7b625e46e7fc6666",
"assets/packages/hyphenator_impure/hyphenate_patterns/hyph-ro.tex": "0b4d746603b42894a4d5f3cf952ff960",
"assets/packages/hyphenator_impure/hyphenate_patterns/hyph-fr.tex": "4479446a11e1366b5a18e408bfbc3c19",
"assets/packages/hyphenator_impure/hyphenate_patterns/hyph-el.tex": "c2f93558ffff093b2d9cbcecd0bbee9c",
"assets/packages/hyphenator_impure/hyphenate_patterns/hyph-pl.tex": "58fa3d45b6c75194708646fba2dba354",
"assets/packages/hyphenator_impure/hyphenate_patterns/hyph-sv.tex": "7c3936b4070535e7ca92a0223475d16a",
"assets/packages/hyphenator_impure/hyphenate_patterns/hyph-da.tex": "c3c16b9bc1a0a4d5289b3caf71e01011",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/NOTICES": "8490d464382153f3976957579a640f27",
"main.dart.js_23.part.js": "63d68d4f2382ee30d7d1cdb3e0f8b68b",
"main.dart.js_111.part.js": "72d43f155577e1171f4c61ce729767a3",
"main.dart.js_114.part.js": "e4ebe44e14bb038f28eb8e08fea6c982",
"main.dart.js_100.part.js": "129b9600b80a1136d42a62394e10f2cb",
"manifest.json": "f41a1bcf7dd669f69c5758ad491dac0c",
"main.dart.js_78.part.js": "206d7ab74d45216727b8c71e437ea45e",
"main.dart.js_35.part.js": "9cb3182bb911793311bdb570af057e96",
"version.json": "6b8b9140b83c40f85633ddfcd9f81cd7",
"main.dart.js_109.part.js": "2525151fa65f9b469de9c898e4d96d0a",
"main.dart.js_2.part.js": "b2732064ee5b74a7fc8fa804ed29accf",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"main.dart.js_80.part.js": "a834eaaeea96ea1476303c52d0c319a1",
"main.dart.js_12.part.js": "79741eff3e257d8720cdf560e6de7785"};
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
