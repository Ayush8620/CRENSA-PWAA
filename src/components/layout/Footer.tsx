"use client";

import Link from "next/link";
import { FooterContent } from "@/types";
import { Twitter, Instagram, Music, Youtube } from "lucide-react";

interface FooterProps {
  content: FooterContent;
}

const getSocialIcon = (iconName: string) => {
  switch (iconName.toLowerCase()) {
    case "twitter":
      return Twitter;
    case "instagram":
      return Instagram;
    case "tiktok":
      return Music;
    case "youtube":
      return Youtube;
    default:
      return Twitter;
  }
};

export default function Footer({ content }: FooterProps) {
  const currentYear = new Date().getFullYear();

  return (
    <footer className="bg-primary-navy text-neutral-white">
      {/* TOP CTA SECTION */}
      <div className="border-b border-neutral-white/10 backdrop-blur-md bg-white/5">
        <div className="container section-padding-sm">
          <div className="text-center max-w-3xl mx-auto">
            <h2 className="text-3xl md:text-4xl lg:text-5xl font-extrabold tracking-tight text-neutral-white mb-4">
              {content.finalCta.title}
            </h2>
            <p className="text-lg md:text-xl text-neutral-white/80 mb-8 leading-relaxed">
              {content.finalCta.description}
            </p>
            <Link
              href={content.finalCta.buttonLink}
              className="inline-block px-8 py-3 rounded-xl bg-primary-neon-yellow text-primary-navy font-semibold text-lg shadow-lg hover:shadow-xl hover:scale-105 transition-all duration-200"
            >
              {content.finalCta.buttonText}
            </Link>
          </div>
        </div>
      </div>

      {/* MIDDLE CONTENT SECTIONS */}
      <div className="container section-padding">
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-5 gap-10 lg:gap-14">
          {/* BRAND + SOCIAL + CONTACT */}
          <div className="lg:col-span-2">
            <Link href="/" className="flex items-center space-x-3 mb-6">
              <div className="w-12 h-12 bg-gradient-primary rounded-xl flex items-center justify-center shadow-md">
                <span className="text-primary-navy font-bold text-2xl">C</span>
              </div>
              <span className="font-bold text-2xl tracking-wide text-neutral-white">
                {content.tagline}
              </span>
            </Link>

            <p className="text-neutral-white/80 mb-6 leading-relaxed text-base">
              {content.description}
            </p>

            <div className="mb-6">
              <h4 className="font-semibold text-neutral-white mb-2 tracking-wide">
                Contact Us
              </h4>
              <a
                href={`mailto:${content.contactEmail}`}
                className="text-neutral-white/80 hover:text-primary-neon-yellow transition-colors duration-200"
              >
                {content.contactEmail}
              </a>
            </div>

            {/* SOCIALS */}
            <div>
              <h4 className="font-semibold text-neutral-white mb-3 tracking-wide">
                Follow Us
              </h4>
              <div className="flex space-x-4">
                {content.socialLinks.map((social) => {
                  const Icon = getSocialIcon(social.icon);
                  return (
                    <a
                      key={social.name}
                      href={social.url}
                      target="_blank"
                      rel="noopener noreferrer"
                      aria-label={social.name}
                      className="w-11 h-11 rounded-xl bg-white/10 shadow-sm flex items-center justify-center 
                                hover:bg-primary-neon-yellow hover:text-primary-navy 
                                hover:scale-110 transition-all duration-200"
                    >
                      <Icon className="w-5 h-5" />
                    </a>
                  );
                })}
              </div>
            </div>
          </div>

          {/* FOOTER LINK SECTIONS */}
          {content.sections.map((section) => (
            <div key={section.title}>
              <h4 className="font-semibold text-lg text-neutral-white mb-4 tracking-wide">
                {section.title}
              </h4>
              <ul className="space-y-3">
                {section.links.map((link) => (
                  <li key={link.href}>
                    <Link
                      href={link.href}
                      className="text-neutral-white/80 hover:text-primary-neon-yellow text-sm transition-colors duration-200"
                    >
                      {link.label}
                    </Link>
                  </li>
                ))}
              </ul>
            </div>
          ))}
        </div>
      </div>

      {/* BOTTOM LEGAL BLOCK */}
      <div className="border-t border-neutral-white/10 backdrop-blur-md bg-white/5">
        <div className="container py-6">
          <div className="flex flex-col md:flex-row justify-between items-center gap-4">
            <p className="text-neutral-white/60 text-sm">
              {content.legal.copyright.replace(
                "2024",
                currentYear.toString()
              )}
            </p>

            <div className="flex flex-wrap justify-center md:justify-end gap-6">
              {content.legal.links.map((link) => (
                <Link
                  key={link.href}
                  href={link.href}
                  className="text-neutral-white/60 hover:text-white text-sm transition-colors duration-200"
                >
                  {link.label}
                </Link>
              ))}
            </div>
          </div>
        </div>
      </div>
    </footer>
  );
}
