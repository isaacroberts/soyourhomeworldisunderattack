'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"main.dart.js": "f34816d07f68a4a3d8e6a4f8dabf0f40",
"main.dart.js_98.part.js": "610db2ce40fd15b827c0488c9a9e31be",
"main.dart.js_66.part.js": "cb66bc629d11ab42d625f5db5f1f4fe4",
"main.dart.js_63.part.js": "13fe7d15ccbc4babb92fb9b51b7ff94e",
"main.dart.js_32.part.js": "cb23e410685f4cd9d7d63815f89a62fe",
"main.dart.js_75.part.js": "00052307c5db6e4af5e93d27b6aa4e95",
"main.dart.js_9.part.js": "19afd06e2527dc512eae52e76c721b2b",
"flutter_bootstrap.js": "2194a92335165ee737bfdced2f6a240f",
"main.dart.js_61.part.js": "ac60be163fc8dc6de99f19fd31b07850",
"main.dart.js_64.part.js": "0f5eefc4265509c3dfcb42fa6c128eb5",
"main.dart.js_60.part.js": "52ac46e32f337f66fb88896de0d35fb6",
"main.dart.js_102.part.js": "7b792dba01c6d11446f75ce61a6b0f20",
"main.dart.js_76.part.js": "7265df128915e53ec679e7672887b7b1",
"main.dart.js_106.part.js": "99ccb1ae612eb184c7b46113dcdd484a",
"main.dart.js_62.part.js": "c8f83dfd1fd74caf6fcb341ef72ebfde",
"main.dart.js_68.part.js": "d91d055b78600bb86476ae4cd4efbc34",
"main.dart.js_83.part.js": "0f7632004eaad05340add02921affad4",
"canvaskit/canvaskit.js.symbols": "bdcd3835edf8586b6d6edfce8749fb77",
"canvaskit/canvaskit.wasm": "7a3f4ae7d65fc1de6a6e7ddd3224bc93",
"canvaskit/chromium/canvaskit.js.symbols": "b61b5f4673c9698029fa0a746a9ad581",
"canvaskit/chromium/canvaskit.wasm": "f504de372e31c8031018a9ec0a9ef5f0",
"canvaskit/chromium/canvaskit.js": "8191e843020c832c9cf8852a4b909d4c",
"canvaskit/skwasm.wasm": "39dd80367a4e71582d234948adc521c0",
"canvaskit/skwasm.js.symbols": "e72c79950c8a8483d826a7f0560573a1",
"canvaskit/canvaskit.js": "728b2d477d9b8c14593d4f9b82b484f3",
"canvaskit/skwasm.js": "ea559890a088fe28b4ddf70e17e60052",
"main.dart.js_79.part.js": "d547c99bf9cf784535e1abcbd0cebbd3",
"main.dart.js_71.part.js": "77744b05bd9b0f1d14f7efea91e9a804",
"main.dart.js_41.part.js": "cc662490c6750f1fe8d668ea8983a83a",
"main.dart.js_50.part.js": "2cf9261106e3b16fb54f7f71eed5da87",
"main.dart.js_40.part.js": "a6829124b6be3ca85a488794ffbb2d96",
"main.dart.js_113.part.js": "89c60fb49e2a344f244a38520eaa11d2",
"main.dart.js_101.part.js": "0755792d2dd7d0398f5c850d303cfb86",
"main.dart.js_30.part.js": "9bcbd9a6777b29590f7b6a2846c2e250",
"main.dart.js_51.part.js": "961fc86c55e18c73af4c5e59558a3afb",
"main.dart.js_28.part.js": "7c908c0e529c6fc3eeff58c3f003682a",
"main.dart.js_29.part.js": "64a18039bb762a40f1faef62ce405689",
"main.dart.js_7.part.js": "a977246199007a9582ca81a1f88c4294",
"main.dart.js_91.part.js": "cbeb45c8bb10e557d2eb9ff14ac2821b",
"main.dart.js_8.part.js": "501ffa678a07240640e7088f83797162",
"main.dart.js_25.part.js": "07614b6c923fef293f3e214e1fec0fd3",
"main.dart.js_103.part.js": "564afc471ace1e669e3646bd333ee0dc",
"main.dart.js_1.part.js": "a3bfb275ebedeb3a3dafd205dc4e7bb6",
"main.dart.js_3.part.js": "5938670ee7df6d00465409aaa4a9ab4e",
"main.dart.js_34.part.js": "8b87294023eda3426ca6c512089582a3",
"main.dart.js_126.part.js": "1ceddded6887732f6cb4d53b42c2a586",
"main.dart.js_22.part.js": "041bb8929a684b53446b1ca57d0a8207",
"main.dart.js_14.part.js": "114a7015fb8cb23cf70d4081b3bd3104",
"main.dart.js_49.part.js": "0a55af5781d4d18707eccd63e10aa0ed",
"main.dart.js_20.part.js": "9cca7b4ed56a9156f9ede55fe6a8aacf",
"main.dart.js_118.part.js": "ae6c5da665d35da241c006eab15a4dfc",
"main.dart.js_105.part.js": "85266289b9c0a0da5824306bc0517296",
"main.dart.js_6.part.js": "3f46a3e241a308710478b59097797157",
"main.dart.js_87.part.js": "3cf5e0524e7c82cb02fb10d7c576f5f1",
"main.dart.js_46.part.js": "4cee0815a1ac395fd55fc21e5739cb11",
"main.dart.js_16.part.js": "4849fc0f4c4c4eff0c0dd384e14c3808",
"main.dart.js_5.part.js": "ea97607b9d97735cf383a111f67b5ee4",
"main.dart.js_57.part.js": "817c507df8f8184ea7f5111384f49d4b",
"main.dart.js_82.part.js": "3e996ea99e9c1b89de69d2100f41f99a",
"main.dart.js_17.part.js": "abf40badb79b1304d22e370360b92e07",
"main.dart.js_36.part.js": "b1ceb4dcf43639ac9dfe687e67e1c6c7",
"main.dart.js_15.part.js": "56de9c82f6ce96407213a3cdfeb08fde",
"main.dart.js_31.part.js": "4b35ff12afa9608cdad1f29891ae151d",
"main.dart.js_21.part.js": "5958ccfea86eca6f62d47273f24af06b",
"main.dart.js_10.part.js": "76d052c1f97f2bbe09a841b62ab2da89",
"main.dart.js_73.part.js": "8afeeb63c64d9893a173fba5c5ad88e1",
"main.dart.js_93.part.js": "2619a3210c537f5c63ee0897f49356fb",
"main.dart.js_115.part.js": "7c08d25802c4bf2217c6b1303397c77f",
"main.dart.js_119.part.js": "cec264a08b845052a4db656ff6dffb22",
"main.dart.js_54.part.js": "7d79c421ed54bced7f7e7083f234572d",
"main.dart.js_123.part.js": "8f7907b1bdaa78c2e54cdaf31db2cfcb",
"main.dart.js_38.part.js": "63e585e1543a8ca277f1a40f0598738f",
"main.dart.js_117.part.js": "03456fd43df37a3612d2981c62e39d9c",
"main.dart.js_116.part.js": "bba9ed5c1cb8a42c66cfad4efbb8a0b6",
"main.dart.js_74.part.js": "d1599ea16bee54eca76f880db1b5102f",
"main.dart.js_125.part.js": "d8ed8c70cb92c053f26021397e2e2426",
"main.dart.js_53.part.js": "1d761011883524e30b0dae6f6118bd32",
"main.dart.js_96.part.js": "03f49bf8ddddbd02bf1f98bbf764a34b",
"main.dart.js_81.part.js": "0853447aa346daafb6ed277ffada0926",
"main.dart.js_19.part.js": "96e986c6271c18e8ed26cc02f27c6835",
"main.dart.js_18.part.js": "aa9b10ae9f7dd6ac6bf90e7fea191284",
"main.dart.js_84.part.js": "d13109d48d490678b7e5162a0afdb126",
"main.dart.js_42.part.js": "7fb10796c640a54be715813baab84bd2",
"main.dart.js_55.part.js": "c7c1c678e6f9fd80766aed45218f35f7",
"main.dart.js_107.part.js": "204e4f94036360a449ffa3be51d35e09",
"main.dart.js_44.part.js": "21c0139be7a7ae38ca6ec759aa9bf3d8",
"main.dart.js_65.part.js": "7e62bf05f4b21941191608cfcc89d835",
"main.dart.js_72.part.js": "113eb57ef963be1dff17ff5ac46de425",
"icons/Icon-maskable-512.png": "274a1e917760a1f046d666e6202d023a",
"icons/Icon-maskable-96.png": "91ebf99f57762a0a291d74ca8992d18c",
"icons/Icon-maskable-128.png": "246028210ed2ad790833d9bae1456df3",
"icons/Icon-192.png": "de2ec02df3a1869af4ad786b508d58d0",
"icons/Icon-maskable-192.png": "0bf4a53e4bdef76509c1639561988a14",
"icons/Icon-512.png": "80a96cdf564eb56bf72144a81d528408",
"main.dart.js_77.part.js": "c407eba04b2503e2aa68ac59968ea866",
"main.dart.js_85.part.js": "03e9046d8d352217e593cf2cf57794f8",
"main.dart.js_108.part.js": "72facaeee281308b33362a3ef5898d30",
"main.dart.js_59.part.js": "841138d15ae01ac754c8fe2a6db3a23b",
"main.dart.js_94.part.js": "09a26c5f2c07a1d968ed5403ba713cbb",
"main.dart.js_89.part.js": "b7468819628c4896d537ce438c16aae2",
"main.dart.js_70.part.js": "9c7897f454754f4a18c39ee6fd5f9e40",
"main.dart.js_33.part.js": "7afc4d60c073b6ff8bf579a63ccab052",
"flutter.js": "83d881c1dbb6d6bcd6b42e274605b69c",
"main.dart.js_58.part.js": "67ed9c7ec09d0a06ca26305a1e5a5179",
"main.dart.js_24.part.js": "54e7d440a0166bbe310181c922f73e87",
"main.dart.js_48.part.js": "0c960e90e7af0c6d83f733baf30c5dc8",
"main.dart.js_92.part.js": "2d8895be1a2092f39c586a5522c4fc4a",
"main.dart.js_110.part.js": "09b4e13514e2ad15e4c17ddba509b9f5",
"main.dart.js_104.part.js": "b996463258f805dfec29428a8bfa3968",
"main.dart.js_11.part.js": "60a093cf7e6b57840f06feb18c3d7258",
"main.dart.js_124.part.js": "66300e31a81647d9dfc0870c869f0e41",
"index.html": "82b2b56fc1dbb6c967c1c5e00bbb3ac7",
"/": "82b2b56fc1dbb6c967c1c5e00bbb3ac7",
"main.dart.js_4.part.js": "07a848fe8b224078c06a91ecb8212712",
"main.dart.js_97.part.js": "f1a45713b6aaeba2d2b233e87d715b39",
"main.dart.js_26.part.js": "97b67672c53b148dff6c0ee545e513f8",
"main.dart.js_47.part.js": "516da692e0b6c3c824cbf8ccc27a5591",
"main.dart.js_127.part.js": "e6d1fab7a4a4458e2587da11db897388",
"main.dart.js_37.part.js": "091bdf083ab0f03c0f09e3c2ec587f5e",
"main.dart.js_27.part.js": "83eaabafb619f3dfe95866fd36b260d7",
"main.dart.js_99.part.js": "42f2d091ea59957462a2d0af0523b3f0",
"main.dart.js_13.part.js": "4eb35dcff49798679be79ae474e695ce",
"main.dart.js_112.part.js": "dc1726c4cc8384676c373f71cbca5f8c",
"main.dart.js_43.part.js": "8570e296f375fa02cdbb285136038e64",
"main.dart.js_39.part.js": "7015341dd4a2d3a7067430713834d803",
"assets/AssetManifest.bin": "eb9126b4e5ae49971137bb64d6cff5f3",
"assets/cargoship/iconttf/RpgAwesome.ttf": "3fb8d0aa42860e8db819f5d3c65834c5",
"assets/cargoship/builtin_fonts/Palatino_bold.ttf": "975972a205fd91a532d1b7433281af70",
"assets/cargoship/builtin_fonts/Palatino_italic.ttf": "be4590eba976dace111b6686f6dade52",
"assets/cargoship/builtin_fonts/Rubik-VariableFont_wght.ttf": "6d3102fa33194bef395536d580f91b56",
"assets/cargoship/builtin_fonts/Palatino_roman.ttf": "96261bb90c9babbf8042ce7f43200d65",
"assets/cargoship/builtin_fonts/Palatino_bolditalic.ttf": "beef66370e7124eb683514ad9ad07576",
"assets/AssetManifest.bin.json": "3ef8031b6c1baa93e3f709a6f2cdfdad",
"assets/fonts/MaterialIcons-Regular.otf": "0d337b6635cf4efd426f240f754a735b",
"assets/FontManifest.json": "5bf5570bf3efc7b2862937a369b1b0df",
"assets/AssetManifest.json": "e4dae148b301d722c5fc55a227712fab",
"assets/packages/material_symbols_icons/lib/fonts/MaterialSymbolsSharp.ttf": "e949713f8bb3a755d44ac95a5a424214",
"assets/packages/material_symbols_icons/lib/fonts/MaterialSymbolsOutlined.ttf": "4fb63fe6c03df840cb8b7ee14377d412",
"assets/packages/material_symbols_icons/lib/fonts/MaterialSymbolsRounded.ttf": "0ba4bbd8c849291896db1866e45a92e8",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/shaders/water_clouds.frag": "704f028da22dcab33db2ddda3180ca43",
"assets/NOTICES": "4285cfd938c0dbf845be004aa6c43218",
"main.dart.js_88.part.js": "258b248688f7752604cde2c8a73e678a",
"main.dart.js_120.part.js": "8a157e28a44e4f0145c363f80410b2a2",
"main.dart.js_23.part.js": "760f8dc434ddeb76e37751f5cb59e29e",
"main.dart.js_121.part.js": "52500e7067611e0a5d9c5029fe8d75d2",
"main.dart.js_67.part.js": "740602741122bdca028b18177b79599a",
"main.dart.js_111.part.js": "6ef4e2e38e3b481c896aa2231c9ba32f",
"main.dart.js_114.part.js": "e28dce683bde3faca13758c090b7bb7f",
"main.dart.js_122.part.js": "03c05dc1265659e9d815d190cd28edf4",
"main.dart.js_69.part.js": "2e749b2602fa75b2c0198faf2a5d1ac5",
"main.dart.js_100.part.js": "3970330c66996585769e70a219cb9cb5",
"manifest.json": "38212b39dd51df343b19bfa938e9ac4f",
"main.dart.js_78.part.js": "41e07e2313d4b6f632f68aca2fa07f21",
"main.dart.js_90.part.js": "1ec7b0c8cc45ff6b4b3b1f8dd7075048",
"main.dart.js_35.part.js": "b63a702e945d57201719651f10dfbfe2",
"main.dart.js_52.part.js": "65b7dad9a8da201239e8daf1169af320",
"main.dart.js_95.part.js": "9343c161355cc7bb761679eaa60c661a",
"version.json": "6b8b9140b83c40f85633ddfcd9f81cd7",
"main.dart.js_109.part.js": "4a54eccb2bfc75178d6532214fa8dd73",
"main.dart.js_2.part.js": "51967a14f072895ca03b4d69da7cbdae",
"favicon.png": "306e7ba8f0872a8ae25be6aca7d80b7f",
"main.dart.js_45.part.js": "c262438b8ddb888137402f31578545f7",
"main.dart.js_56.part.js": "e3a0553c8d69eb13680d20382d01de5e",
"main.dart.js_80.part.js": "bb65575b33d586945e64660cd871f367",
"main.dart.js_86.part.js": "f0908896ff74dd23b9e3c6809860f4b9",
"main.dart.js_12.part.js": "71c657442d6cc6f619f83446b36072be"};
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
