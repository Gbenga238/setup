// ==UserScript==
// @name         Nexus Keeper
// @namespace    http://tampermonkey.net/
// @version      2025-02-19
// @description  Keeps the power button ON
// @author       Gbenga Olajide
// @match        https://app.nexus.xyz/*
// @icon         https://www.google.com/s2/favicons?sz=64&domain=nexus.xyz
// @grant        none
// @run-at       document-idle
// ==/UserScript==

(function () {
    'use strict';

    console.log("✅ Nexus Keeper loaded in Tampermonkey");

    let observerRunning = false;

    const correct = (button) => {
        if (button.classList.contains("bg-[#ffffff]") || button.disabled) {
            console.log("⚡ Button turned off! Clicking to turn it on...");
            button.click();
        }
    }
    const init = () => {
        console.log("🎯 Running init() to find the button...");

        let img = document.querySelector('img[src$="/power-settings-icon.svg"]');
        if (!img) {
            console.warn("⚠️ Power button image not found! Waiting...");
            return;
        }

        let button = img.parentElement.parentElement // Adjust if needed
        if (!button) {
            console.warn("⚠️ Button container not found!");
            return;
        }
        correct(button)
        
        console.log("✅ Button found:", button);

        // Create a MutationObserver to detect changes
        let observer = new MutationObserver(mutations => {
            mutations.forEach(mutation => {
                if (mutation.type === "attributes") {
                    console.log("🔄 Button attribute changed:", mutation);

                    // If the button is off, click it
                    correct(button)
                }
            });
        });

        // Start observing changes in the button
        observer.observe(button, { attributes: true, attributeFilter: ["class", "disabled"] });
        observerRunning = true;

        console.log("👀 MutationObserver is now watching the button...");
    };

    // Ensure the script runs at the right time
    window.addEventListener("load", () => {
        console.log("🎯 window.load triggered");
        init();

        // If the button isn't there yet, watch the DOM for changes
        if (!observerRunning) {
            const domObserver = new MutationObserver(() => {
                if (!observerRunning) init();
            });

            domObserver.observe(document.body, { childList: true, subtree: true });
        }
    });

})();


