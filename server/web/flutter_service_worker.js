'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"main.dart.js": "2ec5acd23ee76e5eb9e6eaf300ec912a",
"main.dart.js_98.part.js": "610db2ce40fd15b827c0488c9a9e31be",
"main.dart.js_66.part.js": "cb66bc629d11ab42d625f5db5f1f4fe4",
"main.dart.js_63.part.js": "2c9cbd194bc58969c167066d72baba91",
"main.dart.js_32.part.js": "750523d763420114f904e71fc859d183",
"main.dart.js_75.part.js": "7f3b28f88dd4451c0f8110b542b44319",
"main.dart.js_9.part.js": "e542dbbc6807b0a177c2ef91fd22e7bc",
"flutter_bootstrap.js": "c34a4da9111b41a2f29d31bd72c40fc4",
"main.dart.js_61.part.js": "3601a55bd92b960ec4474ead8599f1ad",
"main.dart.js_64.part.js": "2e5454f8b17394d06c453e62b6225476",
"main.dart.js_60.part.js": "4399811eb1725a70fd5b9b2d69c28de7",
"main.dart.js_102.part.js": "0f6e4deea76ab0e667e72cc2632c7085",
"main.dart.js_76.part.js": "86443cec1ee9124740044ded5a3b2101",
"main.dart.js_106.part.js": "6624bfd2cf71521252229d189c59af21",
"main.dart.js_62.part.js": "230eb914c8949ff81938f346d555f862",
"main.dart.js_68.part.js": "389dd88ad2ed673c877426a243572cf7",
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
"main.dart.js_79.part.js": "e50ae7f959c65d5ac5638a7bf0bf365d",
"main.dart.js_71.part.js": "77744b05bd9b0f1d14f7efea91e9a804",
"main.dart.js_41.part.js": "dfd1f29375533b8853521ed29e62cfd6",
"main.dart.js_50.part.js": "6e76516f5afdb7eca5d97013fbe13f20",
"main.dart.js_40.part.js": "363192afb99bd3472b3716d909911487",
"main.dart.js_113.part.js": "cec858f0fb8b5ed3c21526ca228c4092",
"main.dart.js_101.part.js": "468db9acb41b53790bf73f50d40e9f27",
"main.dart.js_30.part.js": "f8ce130cbec5ace4aae77cca5778fffd",
"main.dart.js_128.part.js": "0291f5021db87f1e39ed0d9ca2f8cd63",
"main.dart.js_51.part.js": "e242fa7685af91fc7c84c2cbb2184fce",
"main.dart.js_28.part.js": "7c908c0e529c6fc3eeff58c3f003682a",
"main.dart.js_29.part.js": "2e5cfdf6007ef6a1687a30c6a7d13cb7",
"main.dart.js_7.part.js": "aa6f2134a3c2ea6de73757a7402da39e",
"main.dart.js_91.part.js": "cbeb45c8bb10e557d2eb9ff14ac2821b",
"main.dart.js_8.part.js": "501ffa678a07240640e7088f83797162",
"main.dart.js_25.part.js": "df645f28f2b92ff3faecc5b95b320466",
"main.dart.js_103.part.js": "cffeb9963c8341fe842658feae2b4208",
"main.dart.js_1.part.js": "85d0f219839c9463e5e9e732ff5b8091",
"main.dart.js_3.part.js": "99857ae4b9a955c7288a9442831e5c10",
"main.dart.js_34.part.js": "a1199d61566423126933d50eb6cfc312",
"main.dart.js_126.part.js": "c763fc7640ff0d1812fcb32631b27dc5",
"main.dart.js_22.part.js": "041bb8929a684b53446b1ca57d0a8207",
"main.dart.js_130.part.js": "708b199af94e3345e93cd71b412240c7",
"main.dart.js_14.part.js": "772dd4acfe93abd19b206cbdea46839d",
"main.dart.js_49.part.js": "05a690e5eee35ac91673599e13f2c08b",
"main.dart.js_20.part.js": "9cca7b4ed56a9156f9ede55fe6a8aacf",
"main.dart.js_118.part.js": "0e3e5d61653782602f66a3b03e1543d5",
"main.dart.js_105.part.js": "4ea287bbdd91cd326d5dc8ce2d6ae8ff",
"main.dart.js_6.part.js": "a46771050e626bee73c4001e055253bf",
"main.dart.js_87.part.js": "587093d38b4b7dcf2199e80b158e3319",
"main.dart.js_46.part.js": "4cee0815a1ac395fd55fc21e5739cb11",
"main.dart.js_16.part.js": "e7b802ac4eb0b4df81a70aa06e9f9894",
"main.dart.js_5.part.js": "26b69ee2dcd2c2aca7dc4eaebe0de048",
"main.dart.js_57.part.js": "817c507df8f8184ea7f5111384f49d4b",
"main.dart.js_82.part.js": "da178e89354386514a31c03541fe14ce",
"main.dart.js_17.part.js": "6343de4d077c5a74028b607b5c7cd0ad",
"main.dart.js_36.part.js": "376da599e91c15731bc954802b80bfd2",
"main.dart.js_15.part.js": "9582aeb0bb4afadedcf4eef5d96d1e04",
"main.dart.js_31.part.js": "38709d204c8e53ff8b00cec0ab715888",
"main.dart.js_21.part.js": "5958ccfea86eca6f62d47273f24af06b",
"main.dart.js_10.part.js": "3d100c13db8a17285fbd191e03def90e",
"main.dart.js_73.part.js": "e8919efdd4e291311715f35e2b2e9d97",
"main.dart.js_93.part.js": "0bc58d147e6d04f00611c0e84bbb1d11",
"main.dart.js_115.part.js": "f20e94e1c621e6de89ecb6631a6083e6",
"main.dart.js_119.part.js": "c8e9064af6dcd71d85c66278d51bfdd0",
"main.dart.js_54.part.js": "7d79c421ed54bced7f7e7083f234572d",
"main.dart.js_123.part.js": "8f7907b1bdaa78c2e54cdaf31db2cfcb",
"main.dart.js_38.part.js": "af803eb710545937acb37307a0d72dd2",
"main.dart.js_117.part.js": "077f35320abce3939bb4b4563114a19a",
"main.dart.js_116.part.js": "60905ed382aeef92ff463af4f7f12b65",
"main.dart.js_74.part.js": "d1b7e2c05b5a0b531dcef6b2f3a1bbda",
"main.dart.js_125.part.js": "250c342e738e2257e8ff836f1dc34693",
"main.dart.js_53.part.js": "17b4892a5e738e1cdb5c7368ffc7af40",
"main.dart.js_96.part.js": "03f49bf8ddddbd02bf1f98bbf764a34b",
"main.dart.js_81.part.js": "0a0ef3a2666d9aee677178c1f2d6a413",
"main.dart.js_19.part.js": "18f01ecede37636098be73b4b9419118",
"main.dart.js_18.part.js": "aa9b10ae9f7dd6ac6bf90e7fea191284",
"main.dart.js_84.part.js": "71128b0d131bfa89f1c59c5ebc25caf5",
"main.dart.js_129.part.js": "47e7970f960e693d380eccadbef1242b",
"main.dart.js_42.part.js": "0e0f5ffdd50882153510317bac7d6989",
"main.dart.js_55.part.js": "133af802fa361033b462c1dd82b53cc6",
"main.dart.js_107.part.js": "80cce55b29f7ab93e5c87c11aa8f2be6",
"main.dart.js_44.part.js": "e67bf9dc8dfa4ef4b07abfca49dc89d4",
"main.dart.js_65.part.js": "7e62bf05f4b21941191608cfcc89d835",
"main.dart.js_72.part.js": "40d7d9f08d18ea4669d959dd8617e9ee",
"icons/Icon-maskable-512.png": "274a1e917760a1f046d666e6202d023a",
"icons/Icon-maskable-96.png": "91ebf99f57762a0a291d74ca8992d18c",
"icons/Icon-maskable-128.png": "246028210ed2ad790833d9bae1456df3",
"icons/Icon-192.png": "de2ec02df3a1869af4ad786b508d58d0",
"icons/Icon-maskable-192.png": "0bf4a53e4bdef76509c1639561988a14",
"icons/Icon-512.png": "80a96cdf564eb56bf72144a81d528408",
"main.dart.js_77.part.js": "f6a3f32088213294f66338eed5cff96b",
"main.dart.js_85.part.js": "03e9046d8d352217e593cf2cf57794f8",
"main.dart.js_108.part.js": "54dae2832ed668f390987143fee6b0c4",
"main.dart.js_59.part.js": "ad037de8fbfa0a726c746dd7a1def4f0",
"main.dart.js_94.part.js": "16090ffe0a5179b786282b9e7a889cb7",
"main.dart.js_89.part.js": "a54be5448e7f452a99bcdb36003f0206",
"main.dart.js_70.part.js": "85cb60be624560757def93b24e954c97",
"main.dart.js_33.part.js": "df5ec52e479d3526df5520190fa0d07c",
"flutter.js": "83d881c1dbb6d6bcd6b42e274605b69c",
"main.dart.js_58.part.js": "67ed9c7ec09d0a06ca26305a1e5a5179",
"main.dart.js_24.part.js": "156208ebe0de116bc2630a7f98d905b3",
"main.dart.js_48.part.js": "0c960e90e7af0c6d83f733baf30c5dc8",
"main.dart.js_92.part.js": "c0a3381611880161f6b6b97276feb825",
"main.dart.js_110.part.js": "d981f3886504f50956177888c93a9267",
"main.dart.js_104.part.js": "9503858fb480fe01db94a142d7ed89a2",
"main.dart.js_11.part.js": "e7d1a18b638cfd35b8700f2825f4b229",
"main.dart.js_124.part.js": "028ded90827b2f8a75089822e84f1796",
"index.html": "82b2b56fc1dbb6c967c1c5e00bbb3ac7",
"/": "82b2b56fc1dbb6c967c1c5e00bbb3ac7",
"main.dart.js_4.part.js": "07bb35354955c4706d256671e16e508a",
"main.dart.js_97.part.js": "f1a45713b6aaeba2d2b233e87d715b39",
"main.dart.js_26.part.js": "97b67672c53b148dff6c0ee545e513f8",
"main.dart.js_47.part.js": "516da692e0b6c3c824cbf8ccc27a5591",
"main.dart.js_127.part.js": "44fd050c201688c2296958cc142d99ac",
"main.dart.js_37.part.js": "b4f4b0315545d9f0b6901dacd02d9548",
"main.dart.js_27.part.js": "83eaabafb619f3dfe95866fd36b260d7",
"main.dart.js_99.part.js": "57939bfddec7ee7c19707198cd9eb473",
"main.dart.js_13.part.js": "5c0e80b0e118d45b3c46bc20e1078af2",
"main.dart.js_112.part.js": "6822ef73bfe79c1f7067502bbf170034",
"main.dart.js_43.part.js": "23728121851d77b3817c118da68592b0",
"main.dart.js_39.part.js": "7015341dd4a2d3a7067430713834d803",
"assets/AssetManifest.bin": "eb9126b4e5ae49971137bb64d6cff5f3",
"assets/cargoship/iconttf/RpgAwesome.ttf": "3fb8d0aa42860e8db819f5d3c65834c5",
"assets/cargoship/builtin_fonts/Palatino_bold.ttf": "975972a205fd91a532d1b7433281af70",
"assets/cargoship/builtin_fonts/Palatino_italic.ttf": "be4590eba976dace111b6686f6dade52",
"assets/cargoship/builtin_fonts/Rubik-VariableFont_wght.ttf": "6d3102fa33194bef395536d580f91b56",
"assets/cargoship/builtin_fonts/Palatino_roman.ttf": "96261bb90c9babbf8042ce7f43200d65",
"assets/cargoship/builtin_fonts/Palatino_bolditalic.ttf": "beef66370e7124eb683514ad9ad07576",
"assets/AssetManifest.bin.json": "3ef8031b6c1baa93e3f709a6f2cdfdad",
"assets/fonts/MaterialIcons-Regular.otf": "f96211e53e534c1356645921a1704b8a",
"assets/FontManifest.json": "5bf5570bf3efc7b2862937a369b1b0df",
"assets/AssetManifest.json": "e4dae148b301d722c5fc55a227712fab",
"assets/packages/material_symbols_icons/lib/fonts/MaterialSymbolsSharp.ttf": "e949713f8bb3a755d44ac95a5a424214",
"assets/packages/material_symbols_icons/lib/fonts/MaterialSymbolsOutlined.ttf": "1b84da84f226780a46c68d94266ecf36",
"assets/packages/material_symbols_icons/lib/fonts/MaterialSymbolsRounded.ttf": "42f8e09d6b8e90f59fd663a0b53f58e5",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/shaders/water_clouds.frag": "704f028da22dcab33db2ddda3180ca43",
"assets/NOTICES": "4285cfd938c0dbf845be004aa6c43218",
"main.dart.js_88.part.js": "34c97effc166603890b2bc3bea7999ab",
"main.dart.js_120.part.js": "7d47e174ae348d7d33355851e69c67c5",
"main.dart.js_23.part.js": "760f8dc434ddeb76e37751f5cb59e29e",
"main.dart.js_121.part.js": "cff11d8d0accf3b3594f0714b94278b1",
"main.dart.js_67.part.js": "2052c91288c9c95aaabbfaf8f6d869cf",
"main.dart.js_111.part.js": "a7562411eef683c3d6890b43bd70298c",
"main.dart.js_114.part.js": "e28dce683bde3faca13758c090b7bb7f",
"main.dart.js_122.part.js": "c13ea5594655d107dc8591d825fd9aef",
"main.dart.js_69.part.js": "2e749b2602fa75b2c0198faf2a5d1ac5",
"main.dart.js_100.part.js": "66ba456ad9e148a332e493cd5fb98daf",
"manifest.json": "38212b39dd51df343b19bfa938e9ac4f",
"main.dart.js_78.part.js": "f91c7cbf05b082d6fce6dad5d4e25e97",
"main.dart.js_90.part.js": "69130c400895db04e22bc370398347c0",
"main.dart.js_35.part.js": "dea0cdc728e641cb6e26b47997232ae9",
"main.dart.js_52.part.js": "113d840d0436acad5fdaae68a83f9ad9",
"main.dart.js_95.part.js": "9343c161355cc7bb761679eaa60c661a",
"version.json": "6b8b9140b83c40f85633ddfcd9f81cd7",
"main.dart.js_109.part.js": "42c6d5d4b7cdf1b70e1744529280b2fa",
"main.dart.js_2.part.js": "aaed3e1f048bd5346c493cea305dd2ab",
"favicon.png": "306e7ba8f0872a8ae25be6aca7d80b7f",
"main.dart.js_45.part.js": "5c16296932ff267b79a68cd9c635ea7b",
"main.dart.js_56.part.js": "e3a0553c8d69eb13680d20382d01de5e",
"main.dart.js_80.part.js": "87061b5f2c5fc5dd61643d051dbce9de",
"main.dart.js_86.part.js": "ad8beab9a36bc81044bc0b1b4d630249",
"main.dart.js_12.part.js": "869009004099edae411129a7caf5d322"};
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
