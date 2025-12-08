"use client";

import Image from "next/image";
import Link from "next/link";

interface EpisodeCardProps {
    id: string;
    title: string;
    thumbnail: string;
    href: string;
}

export default function EpisodeCard({
    title,
    thumbnail,
    href,
}: EpisodeCardProps) {
    return (
        <Link
            href={href}
            className="flex flex-col w-[150px] sm:w-[170px] cursor-pointer group"
        >
            {/* Thumbnail */}
            <div className="relative w-full pb-[160%] rounded-xl overflow-hidden shadow-md bg-black">
                <div className="absolute inset-0">
                    <Image
                        src={thumbnail}
                        alt={title}
                        fill
                        className="object-cover group-hover:scale-105 transition-transform duration-300"
                        sizes="(max-width: 768px) 150px, 170px"
                    />
                </div>
            </div>

            {/* Title */}
            <p className="mt-2 text-sm font-semibold text-neutral-900 leading-tight line-clamp-2">
                {title}
            </p>
        </Link>
    );
}
