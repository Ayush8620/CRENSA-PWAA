"use client";

import React from "react";
import Image from "next/image";
import { useRouter } from "next/navigation";

export default function FeaturedHeroSection() {
  const router = useRouter();
  return (
    <div className="min-h-screen bg-white">
     
        

      {/* ===== MAIN CONTENT ===== */}
      <main className="mx-auto grid max-w-7xl grid-cols-1 gap-6 p-4 lg:grid-cols-3">
        {/* ===== LEFT FEATURE CARD ===== */}
        <section className="lg:col-span-2 rounded-2xl bg-gray-50 p-4 md:p-6 flex flex-col md:flex-row gap-6">
          {/* Image */}
          <div className="w-full md:w-[45%]">
            <div className="relative h-[380px] w-full overflow-hidden rounded-xl">
              <Image
                src="/images/image.png"
                alt="Queen Mom Rules"
                fill
                className="object-cover cursor-pointer hover:opacity-90 transition-opacity"
                onClick={() => router.push('http://localhost:3000/watch/0d6f982f-5dcb-4b83-b971-349f399a30b3')}
              />
            </div>
          </div>

          {/* Content */}
          <div className="flex flex-1 flex-col justify-between">
            <div>
              <h1 className="text-2xl font-bold text-gray-900">
                Queen Mom Rules
              </h1>
              <p className="mt-2 text-sm text-gray-500">63 Episodes</p>

              <p className="mt-4 text-sm leading-relaxed text-gray-600">
                At her parents' anniversary party, a successful CEO is dismissed as a
                low-class nobody, her diamond gift is called fake, and she's even banned
                from the table!
              </p>
            </div>

            {/* Tags */}
            <div className="mt-4 flex flex-wrap gap-2">
              {["Family", "Strong Female Lead", "CEO"].map((tag) => (
                <span
                  key={tag}
                  className="rounded-full bg-gray-100 px-4 py-1 text-xs text-gray-600"
                >
                  {tag}
                </span>
              ))}
            </div>
          </div>
        </section>

        {/* ===== RIGHT COLUMN CARDS ===== */}
        <aside className="flex flex-col gap-4">
          {/* Card 1 */}
          <div className="flex gap-4 rounded-2xl bg-gray-50 p-4">
            <div className="relative h-36 w-24 flex-shrink-0 overflow-hidden rounded-lg">
              <Image
                src="/images/image.png"
                alt="Escape With Boss's Baby"
                fill
                className="object-cover cursor-pointer hover:opacity-90 transition-opacity"
                onClick={() => router.push('http://localhost:3000/watch/0d6f982f-5dcb-4b83-b971-349f399a30b3')}
              />
            </div>

            <div className="flex flex-col justify-between">
              <div>
                <h3 className="text-base font-semibold text-gray-900">
                  Escape With Boss's Baby
                </h3>
                <p className="text-xs text-gray-500 mt-1">53 Episodes</p>
                <p className="mt-2 text-xs text-gray-600 line-clamp-3">
                  Hermione Garcia is a famous computer genius and the heiress to the Garcia family...
                </p>
              </div>

              <div className="mt-2 flex flex-wrap gap-2">
                {["Concealed Identity", "Comeback", "CEO"].map((tag) => (
                  <span
                    key={tag}
                    className="rounded-full bg-gray-100 px-3 py-1 text-[10px] text-gray-600"
                  >
                    {tag}
                  </span>
                ))}
              </div>
            </div>
          </div>

          {/* Card 2 */}
          <div className="flex gap-4 rounded-2xl bg-gray-50 p-4">
            <div className="relative h-36 w-24 flex-shrink-0 overflow-hidden rounded-lg">
              <Image
                src="/images/image.png"
                alt="Love The Way You Lie"
                fill
                className="object-cover cursor-pointer hover:opacity-90 transition-opacity"
                onClick={() => router.push('http://localhost:3000/watch/0d6f982f-5dcb-4b83-b971-349f399a30b3')}
              />
            </div>

            <div className="flex flex-col justify-between">
              <div>
                <h3 className="text-base font-semibold text-gray-900">
                  Love The Way You Lie
                </h3>
                <p className="text-xs text-gray-500 mt-1">59 Episodes</p>
                <p className="mt-2 text-xs text-gray-600 line-clamp-3">
                  Molly’s sister didn’t just swipe her boyfriend Connor — She also snatched her inheritance...
                </p>
              </div>

              <div className="mt-2 flex flex-wrap gap-2">
                {["Sweet Love"].map((tag) => (
                  <span
                    key={tag}
                    className="rounded-full bg-gray-100 px-3 py-1 text-[10px] text-gray-600"
                  >
                    {tag}
                  </span>
                ))}
              </div>
            </div>
          </div>
        </aside>
      </main>
    </div>
  );
}
